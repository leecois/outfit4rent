import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/success/success_screen.dart';
import 'package:outfit4rent/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:outfit4rent/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:outfit4rent/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:outfit4rent/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:outfit4rent/features/shop/screens/checkout/widgets/package_selected.dart';
import 'package:outfit4rent/navigation_menu.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: TAppBar(showBackArrow: true, title: Text('Checkout', style: Theme.of(context).textTheme.headlineSmall)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                // Todo: Package Selected
                const TPackageSelected(),
                const SizedBox(height: TSizes.spaceBtwSections),
                // Todo: Items in Cart
                const TCartItems(
                  showAddRemoveButton: false,
                  physics: NeverScrollableScrollPhysics(),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                //Todo: Billing Section
                TRoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: dark ? TColors.black : TColors.white,
                  child: const Column(
                    children: [
                      //Todo: Pricing
                      TBillingAmountSection(),
                      SizedBox(height: TSizes.spaceBtwItems),
                      //Todo: Divider
                      Divider(),
                      SizedBox(height: TSizes.spaceBtwItems),
                      //Todo: Payment Method
                      TBillingPaymentSection(),
                      SizedBox(height: TSizes.spaceBtwItems),
                      //Todo: Address
                      TBillingAddressSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: () => Get.to(
              () => SuccessScreen(
                image: TImages.successfulPaymentIcon,
                title: 'Payment Success!',
                subtitle: "J4F",
                onPressed: () => Get.offAll(() => const NavigationMenu()),
              ),
            ),
            child: const Text('Place Order \$256'),
          ),
        ));
  }
}
