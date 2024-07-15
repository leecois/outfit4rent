import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:outfit4rent/features/personalization/screens/profile/widgets/my_wardrobe_card.dart';
import 'package:outfit4rent/features/shop/controllers/all_products_controller.dart';
import 'package:outfit4rent/features/shop/models/order_model.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TMyWardrobeCardItem extends StatelessWidget {
  const TMyWardrobeCardItem({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final allProductController = Get.put(AllProductController());

    return Obx(() {
      if (allProductController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final filteredOrders = order.itemInUsers;

      if (filteredOrders.isEmpty) {
        return Center(
          child: Text(
            'No Data Found!',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }

      return TRoundedContainer(
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyWardrobeCard(showBorder: false, order: order),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              height: 120,
              child: ListView.separated(
                itemCount: order.itemInUsers.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
                itemBuilder: (context, itemIndex) {
                  final item = order.itemInUsers[itemIndex];
                  final product = allProductController.products.firstWhere(
                    (p) => p.id == item.productId,
                    orElse: () => ProductModel.empty(),
                  );

                  if (product.id == 0) {
                    return const SizedBox.shrink();
                  }

                  return SizedBox(
                    width: 310,
                    child: TProductCardHorizontal(product: product),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
