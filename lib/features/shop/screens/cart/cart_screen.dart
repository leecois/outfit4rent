import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/loaders/animation_loader.dart';
import 'package:outfit4rent/features/shop/controllers/product/cart_controller.dart';
import 'package:outfit4rent/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:outfit4rent/features/shop/screens/cart/widgets/cart_package_section.dart';
import 'package:outfit4rent/features/shop/screens/checkout/checkout_screen.dart';
import 'package:outfit4rent/navigation_menu.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! Your cart is empty',
          animation: TImages.animation7,
          showAction: false,
          actionText: 'Let\'s shop',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TCartPackageSection(),
              const SizedBox(height: TSizes.spaceBtwSections),
              if (controller.cartItems.isEmpty) emptyWidget else const Expanded(child: TCartItems()),
            ],
          ),
        );
      }),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Obx(() {
                final totalPrice = controller.totalCartPrice.value;
                final canCheckout = controller.selectedPackage.value != null && controller.cartItems.isNotEmpty;
                return ElevatedButton(
                  onPressed: canCheckout ? () => Get.to(() => const CheckoutScreen()) : null,
                  child: Text('Checkout \$$totalPrice'),
                );
              }),
            ),
    );
  }
}
