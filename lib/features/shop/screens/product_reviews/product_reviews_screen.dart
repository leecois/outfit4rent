import 'package:flutter/material.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/products/ratings/rating_bar_indicator.dart';
import 'package:outfit4rent/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:outfit4rent/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      //Todo: Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ratins and review are verified and are from people who use the same type of device that you use."),
              const SizedBox(height: TSizes.spaceBtwItems),

              //Todo: Overall Product Ratings
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 2.2),
              Text("12,242", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              //Todo: User Reviews list
              const TUserReviewCard(),
              const TUserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
