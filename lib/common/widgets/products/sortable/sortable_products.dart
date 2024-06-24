import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:outfit4rent/features/shop/controllers/all_products_controller.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);

    return Column(
      children: [
        // Dropdown for sorting
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort_outline)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            if (value != null) {
              controller.sortProducts(value);
            }
          },
          items: ['Name', 'Higher Deposit', 'Lower Deposit'].map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Products Grid
        Obx(() => TGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) => TProductCardVertical(product: controller.products[index]),
            )),
      ],
    );
  }
}
