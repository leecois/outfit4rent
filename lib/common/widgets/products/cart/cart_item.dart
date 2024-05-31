import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/images/rounded_image.dart';
import 'package:outfit4rent/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Todo: Image
        TRoundedImage(
          imageUrl: TImages.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.softGrey,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        //Todo: Title, Price, Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBrandTitleWithVerifiedIcon(title: 'Gucci'),
              const Flexible(child: TProductTitleText(title: 'Gucci Bag Gucci BagGucci BagGucci BagGucci Bag', maxLines: 1)),
              //Todo: Attributes
              Text.rich(TextSpan(children: [
                TextSpan(text: 'Size: ', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: 'M', style: Theme.of(context).textTheme.bodyLarge),
              ]))
            ],
          ),
        )
      ],
    );
  }
}
