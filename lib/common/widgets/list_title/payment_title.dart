import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/features/shop/controllers/product/checkout_controller.dart';
import 'package:outfit4rent/features/shop/models/payment_method_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class TPaymentTitle extends StatelessWidget {
  const TPaymentTitle({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.updateSelectedPaymentMethod(paymentMethod);
        Get.back();
      },
      leading: TRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.light : TColors.white,
        padding: const EdgeInsets.all(TSizes.sm),
        child: paymentMethod.image.isNotEmpty ? Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain) : const Icon(Icons.wallet, color: TColors.primary),
      ),
      title: Text(paymentMethod.walletName),
      trailing: const Icon(Iconsax.arrow_right_2_outline),
    );
  }
}
