import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/products/cart/cart_item.dart';
import 'package:outfit4rent/common/widgets/products/cart/product_quantity_with_add_remove_button.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
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
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      physics: physics,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (_, index) => Column(
        children: [
          //Todo: Cart Item
          const TCartItem(),
          if (showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItems),
          if (showAddRemoveButton)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //Todo: Extra Space
                    SizedBox(width: 70),
                    //Todo: Remove Button
                    TProductQuantityWithAddRemoveButton(),
                  ],
                ),
                TProductPriceText(price: '200')
              ],
            ),
        ],
      ),
    );
  }
}
