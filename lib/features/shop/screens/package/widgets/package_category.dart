import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TPackageCategory extends StatelessWidget {
  const TPackageCategory({
    super.key,
    required this.maxAvailableQuantity,
    required this.categoryName,
  });

  final int maxAvailableQuantity;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Iconsax.direct_right_outline),
        const SizedBox(width: TSizes.spaceBtwItems / 2),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categoryName, style: Theme.of(context).textTheme.labelLarge),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$maxAvailableQuantity ',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.pink),
                    ),
                    TextSpan(
                      text: ' / month *',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
