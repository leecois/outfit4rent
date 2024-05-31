import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:outfit4rent/features/shop/screens/cart/widgets/cart_package_section.dart';
import 'package:outfit4rent/features/shop/screens/checkout/checkout_screen.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        //Todo: Select Package
        padding: EdgeInsets.all(TSizes.defaultSpace),

        //Todo: Items in Cart
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TCartPackageSection(),
            SizedBox(height: TSizes.spaceBtwSections),
            Expanded(
              child: TCartItems(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child: const Text('Checkout \$256'),
        ),
      ),
    );
  }
}
