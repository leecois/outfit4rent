import 'package:flutter/material.dart';
import 'package:outfit4rent/features/shop/screens/product_details/widgets/product_image_slider.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Todo: Product Image Slider
            TProductImageSlider(),
            // Todo: Product Detail
            Padding(
              padding: EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
            )
          ],
        ),
      ),
    );
  }
}
