import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:outfit4rent/features/personalization/screens/my_wardrobe/widgets/my_wardrobe_card.dart';
import 'package:outfit4rent/features/shop/screens/package/package_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class MyWardrobeScreen extends StatelessWidget {
  const MyWardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TRoundedContainer(
                showBorder: true,
                borderColor: TColors.darkGrey,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.all(TSizes.md),
                margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyWardrobeCard(showBorder: false),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Column(
                      children: [
                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
                            itemBuilder: (context, index) => const SizedBox(
                              width: 310, // Ensure the child has a constrained width
                              child: TProductCardHorizontal(),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
