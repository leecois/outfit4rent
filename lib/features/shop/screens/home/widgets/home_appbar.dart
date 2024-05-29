import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:outfit4rent/utils/constants/colors.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OUTFIT4RENT",
              style: Theme.of(context).textTheme.labelMedium!.apply(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              "Welcome? What are you looking for today?",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
        actions: [
          TCartCounterIcon(
            onPressed: () {},
            iconColor: TColors.white,
          )
        ]);
  }
}
