import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/brands/brand_card.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:outfit4rent/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:outfit4rent/features/shop/controllers/all_products_controller.dart';
import 'package:outfit4rent/features/shop/models/brand_model.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final allProductController = Get.put(AllProductController());

    // Filter products by category
    final filteredProducts = allProductController.products.where((product) => product.idBrand == brand.id).toList();
    return Scaffold(
      appBar: TAppBar(title: Text(brand.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Todo: Brand Detail
              TBrandCard(
                showBorder: true,
                brand: brand,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              Obx(() {
                if (allProductController.isLoading.value) return const TVerticalProductShimmer();
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
