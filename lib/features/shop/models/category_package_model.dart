class CategoryPackageModel {
  int categoryId;
  String categoryName;
  int maxAvailableQuantity;

  CategoryPackageModel({
    required this.categoryId,
    required this.categoryName,
    required this.maxAvailableQuantity,
  });

  static CategoryPackageModel empty() => CategoryPackageModel(categoryId: 0, categoryName: '', maxAvailableQuantity: 0);

  factory CategoryPackageModel.fromJson(Map<String, dynamic> json) => CategoryPackageModel(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        maxAvailableQuantity: json["maxAvailableQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "maxAvailableQuantity": maxAvailableQuantity,
      };
}
