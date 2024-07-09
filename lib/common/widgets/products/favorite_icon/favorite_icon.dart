import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/icons/circular_icon.dart';
import 'package:outfit4rent/features/shop/controllers/product/favorites_controller.dart';
import 'package:outfit4rent/utils/constants/colors.dart';

class TFavoriteIcon extends StatelessWidget {
  const TFavoriteIcon({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Obx(() => TCircularIcon(
          icon: controller.isFavorite(productId) ? Iconsax.heart_bold : Iconsax.heart_outline,
          color: controller.isFavorite(productId) ? TColors.error : null,
          onPressed: () => controller.toggleFavoriteProduct(productId),
        ));
  }
}
