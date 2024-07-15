import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/styles/shadows.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/images/rounded_image.dart';
import 'package:outfit4rent/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_add_to_cart_button.dart';
import 'package:outfit4rent/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/features/shop/controllers/brand_controller.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/features/shop/screens/product_details/product_detail_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final brandController = Get.put(BrandController());

    final networkImage = (product.images.isNotEmpty && product.images[0].url.isNotEmpty) ? product.images[0].url : '';
    final image = networkImage.isNotEmpty ? networkImage : TImages.productImage1;

    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailScreen(product: product));
      },
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
                  // isUsed Tag
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: Colors.amber.withOpacity(0.9),
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        product.isUsed == 'False' ? 'new' : 'used',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),
                      ),
                    ),
                  ),
                  // Favorite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TFavoriteIcon(
                      productId: product.id,
                    ),
                  )
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
                    TProductTitleText(title: product.name, smallSize: true),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    // Get the brand name using the brand ID
                    TBrandTitleWithVerifiedIcon(title: brandController.getBrandNameById(product.idBrand)),
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
                        child: TProductPriceText(price: product.deposit.toString()),
                      ),
                    ],
                  ),
                ),
                // Add to cart
                ProductCardAddToCartButton(product: product)
              ],
            )
          ],
        ),
      ),
    );
  }
}
