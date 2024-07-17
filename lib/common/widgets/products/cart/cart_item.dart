import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/images/rounded_image.dart';
import 'package:outfit4rent/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/features/shop/models/cart_item_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartItem,
  });
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      children: cartItem.createItems.map((createItem) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems),
          child: Row(
            children: [
              // Image
              TRoundedImage(
                imageUrl: createItem.imageUrl ?? '',
                isNetworkImage: true,
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: darkMode ? TColors.darkerGrey : TColors.softGrey,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),

              // Title, Price, Size
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TBrandTitleWithVerifiedIcon(title: cartItem.name),
                    Flexible(
                      child: TProductTitleText(
                        title: createItem.name ?? 'Product Name',
                        maxLines: 1,
                      ),
                    ),
                    // Attributes
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Size: ', style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: createItem.size ?? 'N/A', style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
