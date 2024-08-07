import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:outfit4rent/common/widgets/shimmer/category_shimmer.dart';
import 'package:outfit4rent/features/shop/controllers/category_controller.dart';
import 'package:outfit4rent/features/shop/screens/sub_category/sub_categories_screen.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoryShimmer();

      if (categoryController.allCategories.isEmpty) {
        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.allCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.allCategories[index];
            return TVerticalImageText(
              image: category.url,
              title: category.name,
              textColor: dark ? Colors.white : Colors.black,
              onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
            );
          },
        ),
      );
    });
  }
}
