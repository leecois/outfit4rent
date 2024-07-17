import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/list_title/user_profile_title.dart';
import 'package:outfit4rent/features/shop/controllers/review_controller.dart';
import 'package:outfit4rent/features/shop/models/package_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/validators/validation.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({super.key, required this.package});

  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewController());

    return Scaffold(
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: FloatingActionButton.extended(
          onPressed: () async {
            await controller.postReview(package.id);
          },
          backgroundColor: TColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          label: Text('Post Review', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: TColors.white)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: TAppBar(showBackArrow: true, title: Text(package.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reviewFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TUserProfileTitle(onTap: () {}, showActionButton: false),

                Obx(
                  () => Wrap(
                    spacing: 12.0,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          controller.numberStars.value = index + 1;
                        },
                        iconSize: 40.0,
                        icon: Icon(
                          Icons.star,
                          color: index < controller.numberStars.value ? Colors.amber : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Title Input
                TextFormField(
                  controller: controller.title,
                  validator: (value) => TValidator.validateEmptyText("Title", value),
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.nebulas_nas_outline), labelText: 'Title'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Content Input
                TextFormField(
                  controller: controller.content,
                  validator: (value) => TValidator.validateEmptyText("Content", value),
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.text_outline), labelText: 'Content'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      final image = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (image != null) {
                        controller.selectedImage.value = image;
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.camera_outline),
                        SizedBox(width: TSizes.spaceBtwItems),
                        Text('Add Image'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Image Preview
                Obx(() {
                  if (controller.selectedImage.value != null) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(controller.selectedImage.value!.path),
                                height: 180,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectedImage.value = null;
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 12,
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
