import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/brands/brand_showcase.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/models/category_model.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Brand
              const TBrandShowcase(images: [TImages.productImage1, TImages.productImage1, TImages.productImage1]),
              const TBrandShowcase(images: [TImages.productImage1, TImages.productImage1, TImages.productImage1]),
              const SizedBox(height: TSizes.spaceBtwItems),

              //Todo Product Grid
              TSectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),

              TGridLayout(itemCount: 4, itemBuilder: (_, index) => const TProductCardVertical()),
            ],
          ),
        ),
      ],
    );
  }
}
