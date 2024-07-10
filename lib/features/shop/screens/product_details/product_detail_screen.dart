import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/controllers/product/images_controller.dart';
import 'package:outfit4rent/features/shop/controllers/product/product_controller.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/product_image_slider.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:outfit4rent/features/shop/screens/product_reviews/product_reviews_screen.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final imagesController = Get.put(ImagesController());
    //Todo Fetch product details when this screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchProductDetail(product.id).then((_) {
        final productDetail = productController.productDetail.value;
        if (productDetail != null) {
          imagesController.getAllProductImages(productDetail);
        }
      });
    });
    return Scaffold(
        bottomNavigationBar: TBottomAddToCart(product: product),
        body: SingleChildScrollView(
            child: Column(
          children: [
            // Todo: Product Image Slider
            TProductImageSlider(product: product),
            // Todo: Product Detail
            Padding(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  //Todo: Rating and Share
                  const TRatingAndShare(),

                  //Todo: Price and Title
                  TProductMetaData(product: product),

                  //Todo: Product Attributes
                  TProductAttributes(product: product),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //Todo: Description
                  const TSectionHeading(title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
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
        )));
  }
}
