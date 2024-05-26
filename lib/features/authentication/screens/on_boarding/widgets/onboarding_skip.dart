import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:outfit4rent/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: Text(
          tr('skip'),
          style: Theme.of(context).textTheme.titleMedium!.apply(fontWeightDelta: 2),
        ),
      ),
    );
  }
}
