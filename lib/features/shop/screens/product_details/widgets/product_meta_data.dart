import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/images/circular_image.dart';
import 'package:outfit4rent/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/enums.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Todo: Price and Deposit
        Row(
          children: [
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.primary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(product.type, style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white)),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            //Price
            Text('\$ 100', style: Theme.of(context).textTheme.titleSmall!.apply(color: dark ? TColors.white : TColors.dark, decoration: TextDecoration.lineThrough)),
            const SizedBox(width: TSizes.spaceBtwItems),
            TProductPriceText(
              price: product.price.toString(),
              isLarge: true,
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //Todo: Title
        TProductTitleText(title: product.name),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //Todo: Stock status
        Row(
          children: [
            const TProductTitleText(
              title: 'Status:',
              smallSize: true,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(product.name, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        //Todo: Brand
        Row(
          children: [
            TCircularImage(
              image: TImages.clothIcon,
              width: 32,
              height: 32,
              overlayColor: dark ? TColors.white : TColors.black,
            ),
            TBrandTitleWithVerifiedIcon(
              title: product.idBrand.toString(),
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
      ],
    );
  }
}
