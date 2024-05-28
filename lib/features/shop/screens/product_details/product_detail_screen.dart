import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/product_image_slider.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:outfit4rent/features/shop/screens/product_reviews/product_reviews_screen.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Todo: Product Image Slider
            const TProductImageSlider(),
            // Todo: Product Detail
            Padding(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  //Todo: Rating and Share
                  const TRatingAndShare(),

                  //Todo: Price and Title
                  const TProductMetaData(),

                  //Todo: Product Attributes
                  const TProductAttributes(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //Todo: Add to Cart
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Add to Cart'))),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //Todo: Description
                  const TSectionHeading(title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const ReadMoreText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consequat nibh. Etiam non elit dui. Nullam vel erat sed mi finibus luctus. Quisque ultrices, turpis sed malesuada gravida, mi risus finibus felis, in lacinia mi nunc sit amet dui. Nulla nec purus feugiat, molestie ipsum et, consequat nibh. Etiam non elit dui. Nullam vel erat sed mi finibus luctus. Quisque ultrices, turpis sed malesuada gravida, mi risus finibus felis, in lacinia mi nunc sit amet dui.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  //Todo: Review
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(
                        title: 'Review(1203)',
                        onPressed: () {},
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => const ProductReviewsScreen()),
                        icon: const Icon(Iconsax.arrow_right_1_bold, size: 18),
                      )
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
