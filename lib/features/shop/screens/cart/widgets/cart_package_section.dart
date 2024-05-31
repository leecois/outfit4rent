import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TCartPackageSection extends StatelessWidget {
  const TCartPackageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.black : TColors.white,
      padding: const EdgeInsets.all(TSizes.md),
      child: Column(
        children: [
          Row(
            children: [
              TSectionHeading(
                title: 'Package',
                buttonTitle: 'Change',
                onPressed: () {},
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TProductTitleText(title: 'Price : ', smallSize: true),
                        Flexible(
                          child: Text('\$99', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        const Flexible(child: TProductPriceText(price: '9911', maxLines: 1)),
                      ],
                    ),
                    Row(
                      children: [
                        const TProductTitleText(title: 'Type: ', smallSize: true, maxLines: 1),
                        Flexible(
                          child: Text(
                            'Gold',
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Todo: Variation Description
          const TProductTitleText(
            title: '15 minutes can save you 15 percent or more on car insurance',
            smallSize: true,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
