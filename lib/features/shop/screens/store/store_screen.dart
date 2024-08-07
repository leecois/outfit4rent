import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/appbar/tabbar.dart';
import 'package:outfit4rent/common/widgets/brands/brand_card.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/search_container.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:outfit4rent/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/controllers/brand_controller.dart';
import 'package:outfit4rent/features/shop/controllers/category_controller.dart';
import 'package:outfit4rent/features/shop/screens/brand/all_brands_screen.dart';
import 'package:outfit4rent/features/shop/screens/brand/brand_products_screen.dart';
import 'package:outfit4rent/features/shop/screens/store/widgets/category_tab.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.allCategories;
    final brandsController = Get.put(BrandController());

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Wardrobe', style: Theme.of(context).textTheme.headlineMedium),
          actions: [TCartCounterIcon(onPressed: () {}, iconColor: TColors.white)],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(
                        text: 'Search for products',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      TSectionHeading(title: 'Featured Brands', onPressed: () => Get.to(() => const AllBrandsScreen())),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                      Obx(() {
                        if (brandsController.isLoading.value) return const TVerticalProductShimmer();
                        if (brandsController.allBrands.isEmpty) {
                          return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                        }
                        return TGridLayout(
                          itemCount: brandsController.allBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) => TBrandCard(
                            showBorder: true,
                            onTap: () => Get.to(() => BrandProductsScreen(brand: brandsController.allBrands[index])),
                            brand: brandsController.allBrands[index],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                bottom: TTabBar(tabs: categories.map((category) => Tab(child: Text(category.name))).toList()),
              ),
            ];
          },
          body: TabBarView(
            children: categories.map((category) => TCategoryTab(category: category)).toList(),
          ),
        ),
      ),
    );
  }
}
