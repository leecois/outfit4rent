import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/images/circular_image.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class UserWalletScreen extends StatelessWidget {
  const UserWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(showBackArrow: true, title: Text('My Wallet', style: Theme.of(context).textTheme.headlineSmall!.apply(color: Theme.of(context).colorScheme.primary))),
                  TRoundedContainer(
                    showBorder: false,
                    borderColor: TColors.darkGrey,
                    padding: const EdgeInsets.all(TSizes.md),
                    margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                    child: ListTile(
                      leading: const TCircularImage(
                        image: TImages.lightAppLogo,
                        width: 50,
                        height: 50,
                        backgroundColor: TColors.white,
                        padding: 0,
                      ),
                      title: Text(
                        "OUTFIT4RENT",
                        style: Theme.of(context).textTheme.headlineSmall!.apply(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      subtitle: const TProductPriceText(price: '20000'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Iconsax.add_circle_bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSectionHeading(title: 'History', showActionButton: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
