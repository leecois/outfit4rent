import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/controllers/product/checkout_controller.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(
          title: 'Payment Method',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Obx(
          () => controller.wallets.isEmpty
              ? const Text('No payment methods available')
              : Row(
                  children: [
                    TRoundedContainer(
                      width: 40,
                      height: 35,
                      backgroundColor: dark ? TColors.light : TColors.white,
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Image(
                        image: AssetImage(controller.selectedPaymentMethod.value.image),
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.selectedPaymentMethod.value.walletName,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          if (controller.selectedPaymentMethod.value.walletName == "Outfit4rent")
                            Obx(() => Text(
                                  'Balance: \$${controller.userController.user.value.moneyInWallet ?? 0}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: TColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                )),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
