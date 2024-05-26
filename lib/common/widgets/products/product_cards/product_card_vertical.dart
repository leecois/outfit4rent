import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/styles/spacing_styles.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/icons/circular_icon.dart';
import 'package:outfit4rent/common/widgets/images/rounded_image.dart';
import 'package:outfit4rent/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            //!Thumbnail
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  const TRoundedImage(imageUrl: TImages.productImage1, applyImageRadius: true),
                  //!isUsed Tag
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        'used',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),
                      ),
                    ),
                  ),

                  //!Favorite Icon Button
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(icon: Iconsax.heart_bold, color: Colors.red),
                  )
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            //!Details
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(title: 'Dress Coat', smallSize: true),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    TBrandTitleWithVerifiedIcon(title: 'Gucci'),
                  ],
                ),
              ),
            ),

            //Todo: Add Spacer
            const Spacer(),
            //!Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: '21'),
                ),

                //Todo: Add To Cart Button
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(child: Icon(Iconsax.add_bold, color: TColors.white)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
