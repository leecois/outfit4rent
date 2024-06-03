import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/images/circular_image.dart';
import 'package:outfit4rent/common/widgets/shimmer/shimmer_effect.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:outfit4rent/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      //Todo: body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                //Todo: Profile picture
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                      return controller.imageUploading.value
                          ? const TShimmerEffect(width: 80, height: 80, radius: 80)
                          : TCircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              //Todo: Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              //Todo: Heading profile information
              const TSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName())),
              TProfileMenu(title: 'Username', value: controller.user.value.username, onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              //Todo: Heading account information
              const TSectionHeading(title: 'Account Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'User ID', value: controller.user.value.id, icon: Iconsax.copy_outline, onPressed: () {}),
              TProfileMenu(title: 'Email', value: controller.user.value.email, onPressed: () {}),
              TProfileMenu(title: 'Phone', value: controller.user.value.phoneNumber, onPressed: () {}),
              TProfileMenu(title: 'Gender', value: 'Female', onPressed: () {}),
              TProfileMenu(title: 'Country', value: 'Vietnam', onPressed: () {}),
              TProfileMenu(title: 'Date of Birth', value: '01/01/2003', onPressed: () {}),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
