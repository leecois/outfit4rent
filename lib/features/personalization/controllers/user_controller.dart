import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/authentication/authentication_repository.dart';
import 'package:outfit4rent/data/repositories/user/user_repository.dart';
import 'package:outfit4rent/features/authentication/screens/login/login_screen.dart';
import 'package:outfit4rent/features/personalization/models/user_model.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/helpers/network_manager.dart';
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';
import 'package:outfit4rent/utils/popups/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final localStorage = TLocalStorage.instance;
  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final _userRepository = Get.put(UserRepository());
  final GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
    localStorage.readData<int>('currentUser');
  }

  // Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final userId = localStorage.readData<int>('currentUser');

      final userDetail = await _userRepository.fetchUserDetail(userId!);
      if (kDebugMode) {
        print('User Details: $userDetail');
      }
      user.value = userDetail;
      user.refresh();
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save device token
  Future<void> saveDeviceToken(String token) async {
    final userId = localStorage.readData<int>('currentUser');
    if (userId != null) {
      await _userRepository.saveDeviceToken(userId, token);
    } else {
      throw Exception('User ID not found');
    }
  }

  // Save user Record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    final userId = localStorage.readData<int>('currentUser');
    try {
      // Refresh user record
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
          await _userRepository.updateUserDetail(newUser);
          user.value = newUser;
          user.refresh(); // Ensure the UI updates
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
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
        if (kDebugMode) {
          print('User Picture: $imageUrl');
        }
        // Update user profile picture
        user.update((val) {
          val?.picture = imageUrl;
        });
        await _userRepository.updateUserPicture(user.value.id, imageUrl);
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
