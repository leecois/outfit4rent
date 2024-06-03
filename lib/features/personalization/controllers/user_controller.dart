import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/authentication/authentication_repository.dart';
import 'package:outfit4rent/data/repositories/user/user_repository.dart';
import 'package:outfit4rent/features/authentication/screens/login/login_screen.dart';
import 'package:outfit4rent/features/personalization/models/user_model.dart';
import 'package:outfit4rent/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/network_manager.dart';
import 'package:outfit4rent/utils/popups/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final useRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //Todo: Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await useRepository.fetchUserDetail();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //Save user Record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //Refresher user record
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          //Todo: convert name to first name and last name
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          //Todo: Map user data
          final user = UserModel(
            id: userCredentials.user!.uid,
            username: username,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          //Todo: Save user record
          await useRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'An error occurred. Please try again later.',
      );
    }
  }

  //Todo: Delete Account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account?',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Delete')),
      ),
      cancel: ElevatedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  //Todo: Delete Account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.animation5);

      //Todo: First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //Todo: Re-authenticate user
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'facebook.com') {
          await auth.signInWithFacebook();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthenticateUserLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: 'Account not deleted',
        message: 'An error occurred. Please try again later.',
      );
    }
  }

  //Todo: Re-authenticate user
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.animation5);

      //Todo: Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Validate form
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: 'Re-authentication failed',
        message: 'An error occurred. Please try again later.',
      );
    }
  }

  //Todo: Upload profile picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        //Todo: Upload image
        final imageUrl = await useRepository.uploadImage('Users/Images/Profile/', image);
        //Todo: Update user profile picture
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await useRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        TLoaders.successSnackBar(title: 'Profile Picture Updated', message: 'Your profile picture has been updated successfully');
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Profile Picture not updated',
        message: 'An error occurred. Please try again later.',
      );
    } finally {
      imageUploading.value = false;
    }
  }
}
