import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/chips/choice_chip.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({
    super.key,
    required this.product,
  });

  final ProductModel product;

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
                          const TProductTitleText(title: 'Deposit: ', smallSize: true),
                          TProductPriceText(
                            price: (product.deposit * 100).toString(),
                            currencySign: '%',
                          ),
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
              TProductTitleText(
                title: product.description,
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
                TChoiceChip(text: product.size, selected: true, onSelected: (value) {}),
              ],
            )
          ],
        )
      ],
    );
  }
}
