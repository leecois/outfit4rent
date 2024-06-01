import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:outfit4rent/features/shop/screens/sub_category/sub_categories_screen.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return TVerticalImageText(
              image: TImages.clothIcon,
              title: 'Dress',
              textColor: Theme.of(context).colorScheme.primary,
              onTap: () => Get.to(() => const SubCategoriesScreen()),
            );
          }),
    );
  }
}
