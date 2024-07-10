import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/common/widgets/texts/product_title_text.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/controllers/product/cart_controller.dart';
import 'package:outfit4rent/features/shop/screens/package/package_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TCartPackageSection extends StatelessWidget {
  const TCartPackageSection({
    super.key,
    this.showActionButton = true,
  });

  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(() {
      final package = cartController.selectedPackage.value;

      if (package == null) {
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
                    buttonTitle: 'Select',
                    showActionButton: showActionButton,
                    onPressed: () {
                      Get.to(() => const PackageScreen());
                    },
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      package?.description ?? 'No package selected',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }

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
                  showActionButton: showActionButton,
                  onPressed: () {
                    // Navigate to package selection screen
                    Get.to(() => const PackageScreen());
                  },
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(title: 'Price : ', smallSize: true),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Flexible(child: TProductPriceText(price: '${package.price}', maxLines: 1)),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(title: 'Type: ', smallSize: true, maxLines: 1),
                          Flexible(
                            child: Text(
                              package.name,
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
            TProductTitleText(
              title: package.description,
              smallSize: true,
              maxLines: 4,
            ),
          ],
        ),
      );
    });
  }
}
