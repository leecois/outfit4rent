import 'package:outfit4rent/features/shop/models/category_model.dart';

class CategoryPackageModel {
  final int id;
  final int maxAvailableQuantity;
  final int categoryId;
  final int packageId;
  final int status;
  final CategoryModel category;

  CategoryPackageModel({
    required this.category,
    required this.id,
    required this.maxAvailableQuantity,
    required this.categoryId,
    required this.packageId,
    required this.status,
  });

  static CategoryPackageModel empty() {
    return CategoryPackageModel(
      id: 0,
      category: CategoryModel.empty(),
      maxAvailableQuantity: 0,
      categoryId: 0,
      packageId: 0,
      status: 0,
    );
  }

  factory CategoryPackageModel.fromJson(Map<String, dynamic> json) => CategoryPackageModel(
        id: json["id"],
        category: CategoryModel.fromJson(json["category"]),
        maxAvailableQuantity: json["maxAvailableQuantity"],
        categoryId: json["categoryId"],
        packageId: json["packageId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category.toJson(),
        "maxAvailableQuantity": maxAvailableQuantity,
        "categoryId": categoryId,
        "packageId": packageId,
        "status": status,
      };
}
