import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/shimmer/shimmer_effect.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class TPackageShimmer extends StatelessWidget {
  const TPackageShimmer({
    super.key,
    this.itemCount = 2,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SizedBox(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: itemCount,
          scrollDirection: Axis.vertical,
          separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
          itemBuilder: (_, __) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Todo: Image
                TShimmerEffect(width: double.infinity, height: 500, radius: 20),
                SizedBox(height: TSizes.spaceBtwItems),
              ],
            );
          },
        ),
      ),
    );
  }
}
