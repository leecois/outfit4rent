import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/authentication/authentication_repository.dart';
import 'package:outfit4rent/data/repositories/user/user_repository.dart';
import 'package:outfit4rent/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/personalization/models/user_model.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/helpers/network_manager.dart';
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';
import 'package:outfit4rent/utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //? Variables
  final userController = Get.put(UserController());
  final localStorage = TLocalStorage.instance;
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final fullName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  //Todo: SIGNUP
  void signUp() async {
    try {
      //Todo: Start Loading
      TFullScreenLoader.openLoadingDialog("Mô phật đang kiểm tra đợi xíu...", TImages.animation5);

      //Todo: Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'Please accept the privacy policy to continue',
        );
        TFullScreenLoader.stopLoading();
        return;
      }
      //Todo: Register User in Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Todo: Verify token with REST API
      final token = await userCredential.user?.getIdToken();
      final response = await AuthenticationRepository.instance.verifyToken(token!);

      await localStorage.saveData('currentUser', response);
      await userController.fetchUserRecord();

      //Todo: Save User Record
      final newUser = UserModel(
        id: response,
        email: email.text.trim(),
        name: fullName.text.trim(),
        phone: phoneNumber.text.trim(),
        picture: '',
        status: 0,
        address: null,
        moneyInWallet: null,
      );

      //Todo: Save User Record
      final userRepository = Get.put(UserRepository());
      await userRepository.updateUserDetail(newUser);

      // Fetch and save device token
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await userController.saveDeviceToken(fcmToken);
      }

      TFullScreenLoader.stopLoading();

      //Todo: Show Success Message
      TLoaders.successSnackBar(title: "Welcome!", message: "You have successfully signed up");

      //Todo: Move to Verification Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      //Todo: Handle error
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "OMG!", message: e.toString());
    }
  }
}
