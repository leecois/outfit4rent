import 'package:flutter/material.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Todo: Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$99.0', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        //Todo: Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$0.0', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        //Todo: Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$0.0', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        //Todo: Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$777.0', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
