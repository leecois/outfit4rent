import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:outfit4rent/features/shop/controllers/product/product_controller.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    return Column(
      children: [
        //Todo Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort_outline)),
          onChanged: (value) {},
          items: ['Name', 'Newest', 'Popularity', 'Higher Deposit', 'Lower Deposit'].map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        //Todo: Products
        TGridLayout(itemCount: productController.allProducts.length, itemBuilder: (_, index) => TProductCardVertical(product: productController.allProducts[index]))
      ],
    );
  }
}
