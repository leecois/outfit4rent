import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:outfit4rent/common/widgets/icons/circular_icon.dart';
import 'package:outfit4rent/common/widgets/images/rounded_image.dart';
import 'package:outfit4rent/common/widgets/shimmer/shimmer_effect.dart';
import 'package:outfit4rent/features/shop/controllers/product/images_controller.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());

    // Set the initial images for the product
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.productImages.isEmpty) {
        controller.setProductImages([product.imgUrl]);
      }
    });

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            // Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final imageUrl = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(imageUrl),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        progressIndicatorBuilder: (_, __, downloadProgress) => CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: TColors.primary,
                        ),
                        errorWidget: (_, __, ___) => const Center(
                          child: TShimmerEffect(width: double.infinity, height: double.infinity),
                        ),
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: Obx(() {
                  return ListView.separated(
                    itemCount: controller.productImages.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                    itemBuilder: (_, index) => Obx(
                      () {
                        final imageUrl = controller.productImages[index];
                        final isSelected = controller.selectedProductImage.value == imageUrl;
                        return TRoundedImage(
                          width: 80,
                          height: 80,
                          isNetworkImage: true,
                          onPressed: () => controller.updateSelectedImage(imageUrl),
                          backgroundColor: dark ? TColors.dark : TColors.white,
                          border: Border.all(
                            color: isSelected ? Colors.pink : (dark ? TColors.primary : TColors.lightGrey),
                          ),
                          padding: const EdgeInsets.all(TSizes.sm),
                          imageUrl: imageUrl,
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
            // Appbar Icon
            const TAppBar(
              showBackArrow: true,
              actions: [TCircularIcon(icon: Iconsax.heart_bold, color: Colors.red)],
            ),
          ],
        ),
      ),
    );
  }
}
