import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:outfit4rent/utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor = TColors.white,
  });

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: onPressed, icon: const Icon(FluentIcons.shopping_bag_24_regular, color: TColors.white)),
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
                child: Text('2', style: Theme.of(context).textTheme.labelLarge!.apply(color: iconColor, fontSizeFactor: 0.8)),
              )),
        )
      ],
    );
  }
}
