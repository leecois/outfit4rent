import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/styles/spacing_styles.dart';
import 'package:outfit4rent/common/widgets/login_signup/form_divider.dart';
import 'package:outfit4rent/common/widgets/login_signup/social_buttons.dart';
import 'package:outfit4rent/features/authentication/screens/login/widgets/login_form.dart';
import 'package:outfit4rent/features/authentication/screens/login/widgets/login_header.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //Todo: Logo, Title and Subtitle
              const TLoginHeader(),
              //Todo: Form
              const TLoginForm(),
              //Todo: Or Sign In With
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),
              //Todo: Social Login Buttons
              const TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
