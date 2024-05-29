import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:outfit4rent/features/authentication/screens/login/login_screen.dart';
import 'package:outfit4rent/features/authentication/screens/on_boarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //? Variables
  final deviceStorage = GetStorage();

  //? Called from main.dart
  @override
  void onReady() {
    // Todo: implement onReady
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //? Redirects to the appropriate screen
  screenRedirect() async {
    // Local storage
    if (kDebugMode) {
      print('GET STORAGE');
      print(deviceStorage.read('NapLanDau'));
    }
    deviceStorage.writeIfNull('NapLanDau', true);
    deviceStorage.read('NapLanDau') != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(const OnboardingScreen());
  }

  //! EMAIL & PASSWORD SIGN IN AUTHENTICATION
  //Todo: [EmailAuthentication] - Sign In
  //Todo: [EmailAuthentication] - Register
  //Todo: [ReAuthentication] - Re-authenticate user
  //Todo: [EmailAuthentication] - Mail Verification
  //Todo: [EmailAuthentication] - Forget password
  //! FEDERATED IDENTITY & SOCIAL SIGN IN AUTHENTICATION
  // Todo: [GoogleAuthentication] - Google
  // Todo: [FacebookAuthentication] - Facebook
  //! ./end FEDERATED IDENTITY & SOCIAL SIGN IN AUTHENTICATION
  //Todo: [SignOut] - Valid for any authentication method
  //Todo: [DeleteAccount] - Remove user
}
