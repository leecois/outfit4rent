import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/animation_loader.dart';
import 'package:outfit4rent/common/widgets/orders/order_cards/my_wardrobe_card_item.dart';
import 'package:outfit4rent/common/widgets/shimmer/my_wardrobe_shimmer.dart';
import 'package:outfit4rent/features/shop/controllers/product/order_controller.dart';
import 'package:outfit4rent/features/shop/controllers/product/product_controller.dart';
import 'package:outfit4rent/navigation_menu.dart';
import 'package:outfit4rent/utils/constants/enums.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TOrderTab extends StatelessWidget {
  const TOrderTab({
    super.key,
    required this.orderStatus,
  });

  final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final productController = Get.put(ProductController());

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Obx(() {
                  if (productController.isLoading.value || orderController.isLoading.value) {
                    return const TMyWardrobeShimmer();
                  }

                  final filteredOrders = orderController.userOrders.where((order) => order.status == orderStatus).toList();

                  if (filteredOrders.isEmpty) {
                    return TAnimationLoaderWidget(
                      text: 'Whoops! Empty',
                      animation: TImages.animation1,
                      showAction: false,
                      onActionPressed: () => Get.offAll(() => const NavigationMenu()),
                    );
                  }

                  return TMyWardrobeCardItem(order: filteredOrders[index]);
                });
              },
              childCount: 1, // Set childCount to 1 to handle loading and empty state properly
            ),
          ),
        ),
      ],
    );
  }
}
