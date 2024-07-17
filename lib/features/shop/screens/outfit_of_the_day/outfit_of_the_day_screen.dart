import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/reviews/review_card_vertical.dart';
import 'package:outfit4rent/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:outfit4rent/features/shop/controllers/review_controller.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class OutfitOfTheDayScreen extends StatelessWidget {
  const OutfitOfTheDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewController = Get.put(ReviewController());

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Outfit of the day',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Popular products
                  Obx(() {
                    if (reviewController.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }
                    if (reviewController.allReviews.isEmpty) {
                      return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return TGridLayout(
                      itemCount: reviewController.allReviews.length,
                      itemBuilder: (_, index) => TReviewCardVertical(review: reviewController.allReviews[index]),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
