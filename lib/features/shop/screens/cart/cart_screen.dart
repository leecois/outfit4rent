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
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              Get.defaultDialog(
                contentPadding: const EdgeInsets.all(TSizes.md),
                title: 'Clear Cart',
                middleText: 'Are you sure you want to clear your cart?',
                confirm: ElevatedButton(
                  onPressed: () async => {controller.clearCart(), Get.back()},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
                  child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Delete')),
                ),
                cancel: ElevatedButton(
                  onPressed: () => Navigator.of(Get.overlayContext!).pop(),
                  child: const Text('Cancel'),
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! Your cart is empty',
          animation: TImages.animation7,
          showAction: true,
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
              if (controller.cartItems.isEmpty) Expanded(child: emptyWidget) else const Expanded(child: TCartItems()),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const SizedBox.shrink();
        }
        final totalPrice = controller.totalCartPrice.value;
        final canCheckout = controller.selectedPackage.value != null && controller.cartItems.isNotEmpty;
        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: canCheckout ? () => Get.to(() => const CheckoutScreen()) : null,
            child: Text('Checkout \$$totalPrice'),
          ),
        );
      }),
    );
  }
}
