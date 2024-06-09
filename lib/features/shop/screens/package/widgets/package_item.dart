import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/models/package_model.dart';
import 'package:outfit4rent/features/shop/screens/package/widgets/package_category.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

class TPackageItem extends StatelessWidget {
  final PackageModel package;
  final bool isPopular;
  final bool darkMode;
  final VoidCallback? onPressed;

  const TPackageItem({
    super.key,
    required this.package,
    required this.isPopular,
    required this.darkMode,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(
        children: [
          TRoundedContainer(
            showBorder: true,
            backgroundColor: darkMode ? TColors.dark : TColors.white,
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TSectionHeading(
                  title: package.name,
                  showActionButton: false,
                  bigSize: true,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Just ',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: '\$${package.price}',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.pink),
                      ),
                      TextSpan(
                        text: ' / month *',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                ReadMoreText(
                  package.description,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: package.categoryPackages.length,
                  itemBuilder: (context, catIndex) {
                    final category = package.categoryPackages[catIndex];
                    return TPackageCategory(
                      categoryName: category.categoryName,
                      maxAvailableQuantity: category.maxAvailableQuantity,
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const Text('Free shipping & return'),
                const SizedBox(height: TSizes.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Get Started'),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '*${package.price}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.pink),
                      ),
                      TextSpan(
                        text: ' / month from 2nd month',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isPopular)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  'POPULAR',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
