import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:outfit4rent/features/authentication/screens/on_boarding/widgets/onboarding_dot.dart';
import 'package:outfit4rent/features/authentication/screens/on_boarding/widgets/onboarding_next.dart';
import 'package:outfit4rent/features/authentication/screens/on_boarding/widgets/onboarding_page.dart';
import 'package:outfit4rent/features/authentication/screens/on_boarding/widgets/onboarding_skip.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndex,
            children: const [
              OnboardingPage(
                image: TImages.onboarding1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnboardingPage(
                image: TImages.onboarding2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnboardingPage(
                image: TImages.onboarding3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          ///Skip button
          const OnBoardingSkip(),

          ///Dot indicator
          const OnBoardingDot(),

          /// Circle indicator
          const OnBoardingNext()
        ],
      ),
    );
  }
}
