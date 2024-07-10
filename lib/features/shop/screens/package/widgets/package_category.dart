import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/images/rounded_image.dart';
import 'package:outfit4rent/features/shop/models/category_package_model.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TPackageCategory extends StatelessWidget {
  const TPackageCategory({
    super.key,
    required this.categoryPackageModel,
  });
  final CategoryPackageModel categoryPackageModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: categoryPackageModel.category.url,
          isNetworkImage: true,
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(TSizes.sm),
        ),
        const SizedBox(width: TSizes.spaceBtwItems / 2),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categoryPackageModel.category.name, style: Theme.of(context).textTheme.labelLarge),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${categoryPackageModel.maxAvailableQuantity}',
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
