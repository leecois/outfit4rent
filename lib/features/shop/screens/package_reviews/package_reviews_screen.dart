import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/layouts/grid_layout.dart';
import 'package:outfit4rent/common/widgets/products/ratings/rating_bar_indicator.dart';
import 'package:outfit4rent/common/widgets/shimmer/shimmer_effect.dart';
import 'package:outfit4rent/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:outfit4rent/data/repositories/reviews/review_repository.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/shop/controllers/review_controller.dart';
import 'package:outfit4rent/features/shop/models/package_model.dart';
import 'package:outfit4rent/features/shop/models/reviews_model.dart';
import 'package:outfit4rent/features/shop/screens/package_reviews/add_review_screen.dart';
import 'package:outfit4rent/features/shop/screens/package_reviews/widgets/rating_progress_indicator.dart';
import 'package:outfit4rent/features/shop/screens/package_reviews/widgets/user_review_card.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/cloud_helper_functions.dart';

class PackageReviewsScreen extends StatelessWidget {
  const PackageReviewsScreen({super.key, required this.package});

  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    final reviewController = Get.put(ReviewController());
    final user = UserController.instance.user.value;
    reviewController.fetchRatingReviews(package.id);
    reviewController.checkUserReview(package.id, user.id);

    return Scaffold(
      floatingActionButton: Obx(() {
        if (reviewController.userReview.value == null) {
          return FloatingActionButton(
            onPressed: () => Get.to(() => AddReviewScreen(package: package)),
            backgroundColor: TColors.primary,
            child: const Icon(Iconsax.add_outline, color: TColors.white),
          );
        } else {
          return Container();
        }
      }),
      appBar: TAppBar(
        title: Text(package.name),
        showBackArrow: true,
      ),
      // Todo: Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ratings and review are verified and are from people who use the same type of device that you use."),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Todo: Overall Product Ratings
              Obx(() {
                final rating = reviewController.ratingReviews.value;
                if (rating == null) {
                  return const TShimmerEffect(width: double.infinity, height: 100);
                }

                return Column(
                  children: [
                    TOverallProductRating(ratingReviews: rating),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TRatingBarIndicator(rating: rating.averageStar),
                  ],
                );
              }),
              const SizedBox(height: TSizes.spaceBtwSections),

              // User's own review at the top
              Obx(() {
                final userReview = reviewController.userReview.value;
                if (userReview != null) {
                  return TUserReviewCard(review: userReview);
                } else {
                  return Container();
                }
              }),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // User Reviews list
              FutureBuilder<List<ReviewsModel>>(
                future: ReviewRepository.instance.getReviewsByPackageId(package.id),
                builder: (context, snapshot) {
                  const loader = TShimmerEffect(width: double.infinity, height: 400);
                  final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                  if (widget != null) return widget;

                  final review = snapshot.data!;

                  return Obx(() {
                    if (reviewController.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }
                    if (review.isEmpty) {
                      return Center(child: Text('No Review Found!', style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return TGridLayout(
                      crossAxisCount: 1,
                      mainAxisExtent: 400,
                      itemCount: review.length,
                      itemBuilder: (_, index) => TUserReviewCard(review: review[index]),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
