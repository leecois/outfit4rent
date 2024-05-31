import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/screens/cart/cart_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: () => Get.to(() => const CartScreen()), icon: Icon(FluentIcons.shopping_bag_24_regular, color: Theme.of(context).colorScheme.primary)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: TColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context).textTheme.labelLarge!.apply(color: iconColor, fontSizeFactor: 0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
