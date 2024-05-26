import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/icons/circular_icon.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:outfit4rent/features/shop/screens/home/home_screen.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(icon: Iconsax.add_bold, onPressed: () => Get.to(const HomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [TGridLayout(itemCount: 6, itemBuilder: (_, index) => const TProductCardVertical())],
        ),
      ),
    );
  }
}
