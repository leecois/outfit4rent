import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:outfit4rent/features/personalization/screens/my_wardrobe/widgets/my_wardrobe_card.dart';
import 'package:outfit4rent/features/shop/controllers/product/order_controller.dart';
import 'package:outfit4rent/features/shop/controllers/product/product_controller.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/features/shop/screens/package/package_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class MyWardrobeScreen extends StatelessWidget {
  const MyWardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final productController = Get.find<ProductController>();

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
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (orderController.userOrders.isEmpty) {
          return Center(
            child: Text(
              'No Data Found!',
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          itemCount: orderController.userOrders.length,
          itemBuilder: (context, index) {
            final order = orderController.userOrders[index];
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
                        return FutureBuilder<ProductModel>(
                          future: productController.fetchProductDetail(item.productId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              return SizedBox(
                                width: 310,
                                child: TProductCardHorizontal(product: snapshot.data!),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
