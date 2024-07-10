import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/icons/circular_icon.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/loaders/animation_loader.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:outfit4rent/features/shop/controllers/product/favorites_controller.dart';
import 'package:outfit4rent/navigation_menu.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(icon: Iconsax.add_bold, onPressed: () => Get.offAll(const NavigationMenu())),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() {
          if (controller.favoriteProductsList.isEmpty) {
            return TAnimationLoaderWidget(
              text: 'Whoops! Wishlist is Empty',
              animation: TImages.animation12,
              showAction: true,
              actionText: 'Let\'s add some',
              onActionPressed: () => Get.offAll(() => const NavigationMenu()),
            );
          }
          return TGridLayout(
            itemCount: controller.favoriteProductsList.length,
            itemBuilder: (_, index) => TProductCardVertical(
              product: controller.favoriteProductsList[index],
            ),
          );
        }),
      ),
    );
  }
}
