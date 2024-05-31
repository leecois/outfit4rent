import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:outfit4rent/features/authentication/screens/login/login_screen.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  /// Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  /// Update Current Index when page Scrolled
  void updatePageIndex(index) => currentPageIndex.value = index;

  /// Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  /// Update Current index & jum to the next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();

      if (kDebugMode) {
        print('GET STORAGE');
        print(storage.read('NapLanDau'));
      }

      storage.write('NapLanDau', false);
      Get.offAll(() => const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  /// Update Current index & jum to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
