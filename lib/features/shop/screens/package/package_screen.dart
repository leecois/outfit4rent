import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/shimmer/package_shimmer.dart';
import 'package:outfit4rent/features/shop/controllers/package_controller.dart';
import 'package:outfit4rent/features/shop/screens/package/widgets/package_item.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final PackageController packageController = Get.put(PackageController());

    return Scaffold(
      appBar: const TAppBar(title: Text('Packages'), showBackArrow: true),
      body: Obx(() {
        if (packageController.isLoading.value) return const TPackageShimmer();

        if (packageController.allPackages.isEmpty) {
          return Center(
            child: Text(
              'No Data Found!',
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
            ),
          );
        }
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: packageController.allPackages.length,
                  (context, index) {
                    final package = packageController.allPackages[index];
                    return TPackageItem(
                      onPressed: () {},
                      package: package,
                      isPopular: index == 1,
                      darkMode: dark,
                    );
                  },
                ),
                
              ),
              
            ),
          ],
        );
      }),
    );
  }
}
