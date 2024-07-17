class RatingReviewsModel {
  int packageId;
  int quantityOfReviews;
  double averageStar;
  List<RatingStar> ratingStars;

  RatingReviewsModel({
    required this.packageId,
    required this.quantityOfReviews,
    required this.averageStar,
    required this.ratingStars,
  });

  factory RatingReviewsModel.fromJson(Map<String, dynamic> json) => RatingReviewsModel(
        packageId: json["packageId"],
        quantityOfReviews: json["quantityOfReviews"],
        averageStar: json["averageStar"].toDouble(),
        ratingStars: List<RatingStar>.from(json["ratingStars"].map((x) => RatingStar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "packageId": packageId,
        "quantityOfReviews": quantityOfReviews,
        "averageStar": averageStar,
        "ratingStars": List<dynamic>.from(ratingStars.map((x) => x.toJson())),
      };
}

class RatingStar {
  int starNumber;
  int quantity;
  double rate;

  RatingStar({
    required this.starNumber,
    required this.quantity,
    required this.rate,
  });

  factory RatingStar.fromJson(Map<String, dynamic> json) => RatingStar(
        starNumber: json["starNumber"],
        quantity: json["quantity"],
        rate: json["rate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "starNumber": starNumber,
        "quantity": quantity,
        "rate": rate,
      };
}
