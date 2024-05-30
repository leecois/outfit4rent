import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/animation_loader.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TFullScreenLoader {
  //Open a full screen loader
  // Parameters:
  // 1. text: The text to be displayed on the loader
  // 2. animation: The Lottie animation to be displayed on the loader

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              TAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
