import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:outfit4rent/common/widgets/shimmer/shimmer_effect.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/utils/constants/colors.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

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
          Obx(
            () {
              if (controller.profileLoading.value) {
                return const TShimmerEffect(width: 80, height: 15);
              } else {
                return Text(
                  controller.user.value.fullName,
                  style: Theme.of(context).textTheme.headlineSmall!.apply(color: Theme.of(context).colorScheme.primary),
                );
              }
            },
          ),
        ],
      ),
      actions: [
        TCartCounterIcon(
          onPressed: () {},
          iconColor: TColors.white,
        )
      ],
    );
  }
}
