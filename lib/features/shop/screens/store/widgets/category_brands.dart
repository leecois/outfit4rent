import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/brands/brand_show_case.dart';
import 'package:outfit4rent/features/shop/models/category_model.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return const TBrandShowcase(images: [TImages.productImage1, TImages.productImage1, TImages.productImage1]);
    
  }
}
