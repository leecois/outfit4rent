import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/products/cart/cart_item.dart';
import 'package:outfit4rent/common/widgets/products/cart/product_quantity_with_add_remove_button.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/features/shop/controllers/product/cart_controller.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
    this.physics = const AlwaysScrollableScrollPhysics(),
  });

  final bool showAddRemoveButton;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        physics: physics,
        separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              TCartItem(cartItem: item),
              if (showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItems),
              if (showAddRemoveButton && item.createItems.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        TProductQuantityWithAddRemoveButton(
                          quantity: item.createItems.first.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    TProductPriceText(price: (item.getTotalPrice()).toStringAsFixed(2)),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
