import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: () {}),
        Text('Ackerman Avenue, 17', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('+84 123 1223 232', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child: Text('Ho Chi Minh', style: Theme.of(context).textTheme.bodyMedium)),
          ],
        ),
      ],
    );
  }
}
