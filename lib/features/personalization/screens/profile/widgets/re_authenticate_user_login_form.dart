import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/constants/text_strings.dart';
import 'package:outfit4rent/utils/validators/validation.dart';

class ReAuthenticateUserLoginForm extends StatelessWidget {
  const ReAuthenticateUserLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Re-authenticate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: controller.reAuthFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.verifyEmail,
                validator: TValidator.validateEmail,
                expands: false,
                decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Iconsax.direct_left_outline)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Obx(
                () => TextFormField(
                  obscureText: controller.hidePassword.value,
                  controller: controller.verifyPassword,
                  validator: (value) => TValidator.validateEmptyText('Password', value),
                  decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                      icon: const Icon(MingCute.eye_close_line),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              //Todo: Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), child: const Text('Verify')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
