import 'package:flutter/material.dart';
import 'package:outfit4rent/features/shop/models/rating_reviews_model.dart';
import 'package:outfit4rent/features/shop/screens/package_reviews/widgets/progress_indicator_and_rating.dart';

class TOverallProductRating extends StatelessWidget {
  final RatingReviewsModel ratingReviews;

  const TOverallProductRating({
    super.key,
    required this.ratingReviews,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize all stars to 0
    final allStars = List.generate(
      5,
      (index) => RatingStar(starNumber: index + 1, quantity: 0, rate: 0.0),
    );

    // Update stars with actual data
    for (var star in ratingReviews.ratingStars) {
      allStars[star.starNumber - 1] = star;
    }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            (ratingReviews.averageStar).toStringAsFixed(1),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: allStars.reversed.map((star) {
              return TRatingProgressIndicator(
                text: '${star.starNumber}',
                value: star.rate,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
