import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/appbar/tabbar.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:outfit4rent/features/shop/screens/order/widgets/order_tab.dart';
import 'package:outfit4rent/features/shop/screens/package/package_screen.dart';
import 'package:outfit4rent/utils/constants/enums.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: OrderStatus.values.length,
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text('Order', style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                expandedHeight: 0,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TSectionHeading(title: 'Featured Packages', onPressed: () => Get.to(() => const PackageScreen())),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                      const TPromoSlider(banners: [TImages.promoBanner1, TImages.promoBanner2, TImages.promoBanner1]),
                    ],
                  ),
                ),
                bottom: TTabBar(tabs: OrderStatus.values.map((status) => Tab(child: Text(status.name))).toList()),
              ),
            ];
          },
          body: TabBarView(
            children: OrderStatus.values.map((status) {
              return TOrderTab(orderStatus: status);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
