import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/features/authentication/screens/signup/verify_email.dart';
import 'package:outfit4rent/features/authentication/screens/signup/widgets/terms_and_condition_checkbox.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/constants/text_strings.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(labelText: TTexts.firstName, prefixIcon: Icon(MingCute.user_3_line)),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(labelText: TTexts.lastName, prefixIcon: Icon(MingCute.user_3_line)),
                ),
              )
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Todo: Username
          TextFormField(
            decoration: const InputDecoration(labelText: TTexts.username, prefixIcon: Icon(MingCute.user_3_line)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Todo: Email
          TextFormField(
            decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(MingCute.mailbox_line)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Todo: Phone Number
          TextFormField(
            decoration: const InputDecoration(labelText: TTexts.phoneNo, prefixIcon: Icon(MingCute.phone_line)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Todo: Password
          TextFormField(
            decoration: const InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(MingCute.lock_line),
              suffixIcon: Icon(MingCute.eye_close_line),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Todo: Terms & Conditions
          const TTermsAndConditionCheckbox(),
          const SizedBox(height: TSizes.spaceBtwSections),
          //Todo: Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const VerifyEmailScreen()),
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
