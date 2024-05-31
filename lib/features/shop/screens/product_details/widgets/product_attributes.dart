import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/chips/choice_chip.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        //Todo: Selected and Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Column(
            children: [
              //Todo: Title, Price, and Stock Status
              Row(
                children: [
                  const TSectionHeading(
                    title: 'Variation',
                    showActionButton: false,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(title: 'Price : ', smallSize: true),
                          Text(
                            '\$25',
                            style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          const TProductPriceText(price: '20'),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(title: 'Stock : ', smallSize: true),
                          Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              //Todo: Variation Description
              const TProductTitleText(
                title: 'This is a variation description',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        //Todo: Attributes
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const TSectionHeading(
        //       title: 'Colors',
        //       showActionButton: false,
        //     ),
        //     const SizedBox(height: TSizes.spaceBtwItems / 2),
        //     Wrap(
        //       spacing: 8,
        //       children: [
        //         TChoiceChip(text: 'Green', selected: true, onSelected: (value) {}),
        //         TChoiceChip(text: 'Yellow', selected: false, onSelected: (value) {}),
        //         TChoiceChip(text: 'Blue', selected: true, onSelected: (value) {}),
        //       ],
        //     )
        //   ],
        // ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Size', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: '23', selected: true, onSelected: (value) {}),
                TChoiceChip(text: '24', selected: false, onSelected: (value) {}),
                TChoiceChip(text: '42', selected: true, onSelected: (value) {}),
              ],
            )
          ],
        )
      ],
    );
  }
}
