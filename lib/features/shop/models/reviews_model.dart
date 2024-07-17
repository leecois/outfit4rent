class ReviewsModel {
  int id;
  String content;
  String title;
  int numberStars;
  int status;
  DateTime date;
  int customerId;
  String customerName;
  String customerAvatar;
  int packageId;
  List<Image> images;

  ReviewsModel({
    required this.id,
    required this.content,
    required this.title,
    required this.numberStars,
    required this.status,
    required this.date,
    required this.customerId,
    required this.customerName,
    required this.customerAvatar,
    required this.packageId,
    required this.images,
  });

  static ReviewsModel empty() => ReviewsModel(
        id: 0,
        content: '',
        title: '',
        numberStars: 0,
        status: 0,
        date: DateTime.now(),
        customerId: 0,
        customerName: '',
        customerAvatar: '',
        packageId: 0,
        images: [],
      );

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
        id: json["id"],
        content: json["content"],
        title: json["title"],
        numberStars: json["numberStars"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
        customerId: json["customerId"],
        customerName: json["customerName"],
        customerAvatar: json["customerAvatar"],
        packageId: json["packageId"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "title": title,
        "numberStars": numberStars,
        "status": status,
        "date": date.toIso8601String(),
        "customerId": customerId,
        "customerName": customerName,
        "customerAvatar": customerAvatar,
        "packageId": packageId,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  int id;
  String url;
  int reviewId;

  Image({
    required this.id,
    required this.url,
    required this.reviewId,
  });

  static Image empty() => Image(
        id: 0,
        url: '',
        reviewId: 0,
      );

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        url: json["url"],
        reviewId: json["reviewId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "reviewId": reviewId,
      };
}
