import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/shop/controllers/product/checkout_controller.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final checkoutController = CheckoutController.instance;
    return Obx(() {
      final user = userController.user.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: () => checkoutController.showUpdateAddressModal(context)),
          Row(
            children: [
              const Icon(Icons.person, color: Colors.grey, size: 16),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(user.name, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.grey, size: 16),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(user.phone, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 16),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(child: Text(user.address ?? 'N/A', style: Theme.of(context).textTheme.bodyMedium)),
            ],
          ),
        ],
      );
    });
  }
}
