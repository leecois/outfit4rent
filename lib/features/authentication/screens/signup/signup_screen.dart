import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/login_signup/form_divider.dart';
import 'package:outfit4rent/common/widgets/login_signup/social_buttons.dart';
import 'package:outfit4rent/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Todo: Logo, Title and Subtitle
              Text(TTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              //Todo: Form
              const TSignupForm(),
              const SizedBox(height: TSizes.spaceBtwSections),
              //Todo: Divider
              TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),
              //Social Buttons
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
