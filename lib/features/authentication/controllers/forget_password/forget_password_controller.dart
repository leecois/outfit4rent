import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/authentication/authentication_repository.dart';
import 'package:outfit4rent/features/authentication/screens/password_configuration/reset_password_screen.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/helpers/network_manager.dart';
import 'package:outfit4rent/utils/popups/full_screen_loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();
  //? Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //Todo: Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog('Sending reset password email...', TImages.animation10);

      //Todo: Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Validate form
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Send Password Reset Email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //Todo: Remove loading
      TFullScreenLoader.stopLoading();

      //Todo: Show success message
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Please check your email to reset your password'.tr);

      //Todo: Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
    }
  }

  //Todo: Resend Password Reset Email
  resendPasswordResetEmail(String email) async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog('Sending reset password email...', TImages.animation10);

      //Todo: Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Todo: Send Password Reset Email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //Todo: Remove loading
      TFullScreenLoader.stopLoading();

      //Todo: Show success message
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Please check your email to reset your password'.tr);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
    }
  }
}
