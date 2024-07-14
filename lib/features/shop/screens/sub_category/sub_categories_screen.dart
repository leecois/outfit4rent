import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/images/rounded_image.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:outfit4rent/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:outfit4rent/features/shop/controllers/product/product_controller.dart';
import 'package:outfit4rent/features/shop/models/category_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final filteredProducts = productController.allProducts.where((product) => product.idCategory == category.id).toList();
    return Scaffold(
      appBar: TAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TRoundedImage(
                width: double.infinity,
                imageUrl: category.url,
                backgroundColor: TColors.white,
                height: 100,
                isNetworkImage: true,
                applyImageRadius: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Sub Categories
              Obx(() {
                if (productController.isLoading.value) return const TVerticalProductShimmer();
                if (filteredProducts.isEmpty) {
                  return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                }
                return TGridLayout(
                  itemCount: filteredProducts.length,
                  itemBuilder: (_, index) => TProductCardVertical(product: filteredProducts[index]),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
