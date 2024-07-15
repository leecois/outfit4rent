import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/orders/order_cards/my_wardrobe_card_item.dart';
import 'package:outfit4rent/common/widgets/shimmer/my_wardrobe_shimmer.dart';
import 'package:outfit4rent/features/shop/controllers/all_products_controller.dart';
import 'package:outfit4rent/features/shop/controllers/product/order_controller.dart';
import 'package:outfit4rent/features/shop/screens/package/package_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/enums.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class MyWardrobeScreen extends StatelessWidget {
  const MyWardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final allProductController = Get.put(AllProductController());

    // Fetch all products when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderController.fetchUserOrders();
      allProductController.fetchAllProducts();
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const PackageScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.add_outline, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('My Wardrobe', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        if (orderController.isLoading.value || allProductController.isLoading.value) {
          return const TMyWardrobeShimmer();
        }
        final rentingOrders = orderController.userOrders.where((order) => order.status == OrderStatus.renting).toList();
        if (rentingOrders.isEmpty) {
          return Center(
            child: Text(
              'No Data Found!',
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          itemCount: rentingOrders.length,
          itemBuilder: (context, index) {
            final order = rentingOrders[index];
            return TMyWardrobeCardItem(order: order);
          },
        );
      }),
    );
  }
}
