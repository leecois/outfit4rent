import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/authentication/authentication_repository.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/helpers/network_manager.dart';
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';
import 'package:outfit4rent/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  //? Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  TLocalStorage localStorage = TLocalStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.readData('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.readData('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  //Todo: Email and Password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.animation5);

      //Todo: Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //Todo: Validate form
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Save data if remember me is checked
      if (rememberMe.value) {
        localStorage.saveData('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.saveData('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredential = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Todo: Verify token with REST API
      final token = await userCredential.user?.getIdToken();
      final response = await AuthenticationRepository.instance.verifyToken(token!);

      await localStorage.saveData('currentUser', response);

      //Todo: Remove loading
      TFullScreenLoader.stopLoading();

      //Todo: Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
    }
  }

  //Todo: Google Sign In
  Future<void> googleSignIn() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.animation5);

      //Todo: Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Sign in with google
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      //Todo: Verify token with REST API
      final token = await userCredentials?.user?.getIdToken();
      final response = await AuthenticationRepository.instance.verifyToken(token!);

      await localStorage.saveData('currentUser', response);

      //Todo: Save user record
      await userController.saveUserRecord(userCredentials);

      //Todo: Remove loading
      TFullScreenLoader.stopLoading();

      //Todo: Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
    }
  }

  //Todo: Facebook Sign In
  Future<void> facebookSignIn() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.animation5);

      //Todo: Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Sign in with facebook
      final userCredentials = await AuthenticationRepository.instance.signInWithFacebook();

      //Todo: Verify token with REST API
      final token = await userCredentials?.user?.getIdToken();
      final response = await AuthenticationRepository.instance.verifyToken(token!);

      await localStorage.saveData('currentUser', response);

      //Todo: Save user record
      await userController.saveUserRecord(userCredentials);

      //Todo: Remove loading
      TFullScreenLoader.stopLoading();

      //Todo: Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
    }
  }
}
