import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/features/authentication/controllers/signup/signup_controller.dart';
import 'package:outfit4rent/features/authentication/screens/signup/widgets/terms_and_condition_checkbox.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/constants/text_strings.dart';
import 'package:outfit4rent/utils/validators/validation.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => TValidator.validateEmptyText("FirstName", value),
                  expands: false,
                  decoration: const InputDecoration(labelText: TTexts.firstName, prefixIcon: Icon(MingCute.user_3_line)),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => TValidator.validateEmptyText("LastName", value),
                  expands: false,
                  decoration: const InputDecoration(labelText: TTexts.lastName, prefixIcon: Icon(MingCute.user_3_line)),
                ),
              )
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Todo: Username
          TextFormField(
            controller: controller.username,
            validator: (value) => TValidator.validateEmptyText("Username", value),
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(MingCute.user_3_line),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Todo: Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(MingCute.mailbox_line)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Todo: Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(labelText: TTexts.phoneNo, prefixIcon: Icon(MingCute.phone_line)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Todo: Password
          Obx(
            () => TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(MingCute.lock_line),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? MingCute.eye_close_line : MingCute.eye_line),
                ),
              ),
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
              onPressed: () => controller.signUp(),
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
