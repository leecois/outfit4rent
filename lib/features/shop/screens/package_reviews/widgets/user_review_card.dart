import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:outfit4rent/common/widgets/images/circular_image.dart';
import 'package:outfit4rent/common/widgets/images/rounded_image.dart';
import 'package:outfit4rent/common/widgets/products/ratings/rating_bar_indicator.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/shop/controllers/review_controller.dart';
import 'package:outfit4rent/features/shop/models/reviews_model.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

class TUserReviewCard extends StatelessWidget {
  const TUserReviewCard({
    super.key,
    required this.review,
  });

  final ReviewsModel review;

  @override
  Widget build(BuildContext context) {
    final networkImage = review.customerAvatar;
    final image = networkImage.isNotEmpty ? networkImage : TImages.user;
    final formattedDate = DateFormat('MMM dd, yyyy').format(review.date);
    final reviewController = Get.find<ReviewController>();
    final userController = Get.find<UserController>();
    final currentUser = userController.user.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularImage(
                  image: image,
                  isNetworkImage: networkImage.isNotEmpty,
                  width: 50,
                  height: 50,
                  padding: 0,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(review.customerName, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            if (review.customerId == currentUser.id)
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    reviewController.deleteReview(review.id);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice.toLowerCase(),
                      child: Text(choice),
                    );
                  }).toList();
                },
                icon: const Icon(Icons.more_vert),
              ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Review
        Row(
          children: [
            TRatingBarIndicator(rating: review.numberStars.toDouble()),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(formattedDate, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        Text(review.title, style: Theme.of(context).textTheme.titleMedium),
        ReadMoreText(
          review.content,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
          lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const Center(
          child: TRoundedImage(
            width: 180,
            height: 180,
            fit: BoxFit.fitHeight,
            imageUrl: TImages.productImage1,
            applyImageRadius: true,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
      ],
    );
  }
}
