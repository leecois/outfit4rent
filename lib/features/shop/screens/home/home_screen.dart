import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/search_container.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:outfit4rent/features/shop/screens/home/widgets/home_categories.dart';
import 'package:outfit4rent/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:outfit4rent/features/shop/screens/package/package_screen.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //!Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //!AppBar
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //!Search
                  TSearchContainer(
                    text: 'Search in Wardrobe',
                    onTap: () {},
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //!Categories
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        //!Heading
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        //!Categories
                        const THomeCategories()
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            //!Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  TSectionHeading(title: 'Popular Packages', onPressed: () => Get.to(() => const PackageScreen())),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  //!Promo Slider
                  const TPromoSlider(banners: [TImages.promoBanner1, TImages.promoBanner2, TImages.promoBanner1]),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  //!Heading
                  TSectionHeading(title: 'Popular Products', onPressed: () {}),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  //!Popular products
                  TGridLayout(itemCount: 2, itemBuilder: (_, index) => const TProductCardVertical()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
