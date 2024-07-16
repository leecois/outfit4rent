import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/images/circular_image.dart';
import 'package:outfit4rent/common/widgets/texts/product_price_text.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/personalization/screens/wallet/add_money_screen.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class UserWalletScreen extends StatelessWidget {
  const UserWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.fetchUserRecord();

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
                    child: Obx(() => ListTile(
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
                          subtitle: TProductPriceText(price: controller.user.value.moneyInWallet.toString()),
                          trailing: IconButton(
                            onPressed: () => Get.to(() => const AddMoneyScreen()),
                            icon: Icon(
                              Iconsax.add_circle_bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )),
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
