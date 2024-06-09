import 'package:outfit4rent/features/shop/models/category_package_model.dart';

class PackageModel {
  int id;
  int price;
  String name;
  String description;
  int status;
  List<CategoryPackageModel> categoryPackages;

  PackageModel({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
    required this.status,
    required this.categoryPackages,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json["id"],
        price: json["price"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        categoryPackages: List<CategoryPackageModel>.from(json["categoryPackages"].map((x) => CategoryPackageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "name": name,
        "description": description,
        "status": status,
        "categoryPackages": List<dynamic>.from(categoryPackages.map((x) => x.toJson())),
      };
}
