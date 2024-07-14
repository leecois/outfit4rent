import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/orders/order_cards/my_wardrobe_card_item.dart';
import 'package:outfit4rent/common/widgets/shimmer/my_wardrobe_shimmer.dart';
import 'package:outfit4rent/features/shop/controllers/product/order_controller.dart';
import 'package:outfit4rent/features/shop/controllers/product/product_controller.dart';
import 'package:outfit4rent/utils/constants/enums.dart';
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

    // Filter orders by status
    final filteredOrders = orderController.userOrders.where((order) => order.status == orderStatus).toList();

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (productController.isLoading.value || orderController.isLoading.value) {
                  return const TMyWardrobeShimmer();
                }

                if (filteredOrders.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Found!',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }

                return TMyWardrobeCardItem(order: filteredOrders[index]);
              },
              childCount: filteredOrders.length,
            ),
          ),
        ),
      ],
    );
  }
}
