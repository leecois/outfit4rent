class CategoryPackageModel {
  int id;
  int maxAvailableQuantity;
  int categoryId;
  int packageId;
  int status;

  CategoryPackageModel({
    required this.id,
    required this.maxAvailableQuantity,
    required this.categoryId,
    required this.packageId,
    required this.status,
  });

  factory CategoryPackageModel.fromJson(Map<String, dynamic> json) => CategoryPackageModel(
        id: json["id"],
        maxAvailableQuantity: json["maxAvailableQuantity"],
        categoryId: json["categoryId"],
        packageId: json["packageId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "maxAvailableQuantity": maxAvailableQuantity,
        "categoryId": categoryId,
        "packageId": packageId,
        "status": status,
      };
}
