import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/brands/brand_card.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/features/shop/controllers/brand_controller.dart';
import 'package:outfit4rent/features/shop/screens/brand/brand_products_screen.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Todo: Heading
              const TSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              //Todo: Brands List
              TGridLayout(
                itemCount: brandController.allBrands.length,
                mainAxisExtent: 80,
                itemBuilder: (context, index) => TBrandCard(
                  showBorder: true,
                  onTap: () => Get.to(() => BrandProductsScreen(brand: brandController.allBrands[index])),
                  brand: brandController.allBrands[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
