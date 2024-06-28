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
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';
import 'package:outfit4rent/utils/popups/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final localStorage = TLocalStorage();
  final _userRepository = Get.put(UserRepository());
  final GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchUserRecord());
  }

  // Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final userId = localStorage.readData<int>('currentUser');
      final userDetail = await _userRepository.fetchUserDetail(userId!);

      user(userDetail);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user Record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    final userId = localStorage.readData<int>('currentUser');
    try {
      // Refresher user record
      await fetchUserRecord();
      if (user.value.name.isEmpty) {
        if (userCredentials != null) {
          // Map user data
          final newUser = UserModel(
            id: userId!,
            name: userCredentials.user!.displayName ?? '',
            email: userCredentials.user!.email ?? '',
            phone: userCredentials.user!.phoneNumber ?? '',
            picture: userCredentials.user!.photoURL ?? '',
            address: '',
            status: 0,
            moneyInWallet: 0,
          );

          // Save user record
          await _userRepository.saveUserRecord(newUser);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'An error occurred. Please try again later.',
      );
    }
  }

  // Delete Account warning
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

  // Delete Account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.animation5);

      // First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re-authenticate user
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

  // Re-authenticate user
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.animation5);

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate form
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

  // Upload profile picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // Upload image
        final imageUrl = await _userRepository.uploadImage('Users/Images/Profile/', image);
        // Update user profile picture
        Map<String, dynamic> json = {'picture': imageUrl};
        await _userRepository.updateSingleField(json);

        user.value.picture = imageUrl;
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
