import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/styles/shadows.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/images/circular_image.dart';
import 'package:outfit4rent/common/widgets/images/rounded_image.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/features/shop/controllers/package_controller.dart';
import 'package:outfit4rent/features/shop/models/reviews_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TReviewCardVertical extends StatelessWidget {
  const TReviewCardVertical({super.key, required this.review});

  final ReviewsModel review;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final packageController = Get.put(PackageController());

    final networkImage = (review.images.isNotEmpty && review.images[0].url.isNotEmpty) ? review.images[0].url : '';
    final image = networkImage.isNotEmpty ? networkImage : TImages.lightAppLogo;

    final networkImage2 = review.customerAvatar;
    final image2 = networkImage2.isNotEmpty ? networkImage2 : TImages.user;

    return Container(
      width: 180,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.white,
      ),
      child: Column(
        children: [
          // Thumbnail
          TRoundedContainer(
            height: 180,
            width: 180,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                TRoundedImage(
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl: image,
                  applyImageRadius: true,
                  isNetworkImage: networkImage.isNotEmpty,
                ),
                Positioned(
                  top: 12,
                  child: TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: Colors.amberAccent.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text(
                      packageController.getPackageNameById(review.packageId),
                      style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),

          // Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(
                    title: review.title,
                    smallSize: false,
                    maxLines: 1,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TProductTitleText(
                    title: review.content,
                    smallSize: true,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),
          // Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: TSizes.sm),
                      child: Row(
                        children: [
                          TCircularImage(
                            image: image2,
                            isNetworkImage: networkImage2.isNotEmpty,
                            width: 20,
                            height: 20,
                            padding: 0,
                          ),
                          const SizedBox(width: TSizes.xs),
                          // Customer Name
                          TProductTitleText(
                            title: review.customerName,
                            smallSize: true,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
