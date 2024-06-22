import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/brands/brand_show_case.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:outfit4rent/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/controllers/product/product_controller.dart';
import 'package:outfit4rent/features/shop/models/category_model.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    // Filter products by category
    final filteredProducts = productController.allProducts.where((product) => product.idCategory == category.id).toList();

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            // Brand showcase
            const TBrandShowcase(images: [TImages.productImage1, TImages.productImage1, TImages.productImage1]),
            const TBrandShowcase(images: [TImages.productImage1, TImages.productImage1, TImages.productImage1]),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Product Grid
            TSectionHeading(title: 'You might like', onPressed: () {}),
            const SizedBox(height: TSizes.spaceBtwItems),

            Obx(() {
              if (productController.isLoading.value) return const TVerticalProductShimmer();
              if (filteredProducts.isEmpty) {
                return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
              }

              return TGridLayout(
                itemCount: filteredProducts.length,
                itemBuilder: (_, index) => TProductCardVertical(product: filteredProducts[index]),
              );
            }),
          ]),
        )
      ],
    );
  }
}
