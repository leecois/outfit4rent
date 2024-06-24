import 'package:outfit4rent/features/shop/models/category_package_model.dart';

class PackageModel {
  int id;
  int price;
  String imageUrl;
  int availableRentDays;
  String name;
  String description;
  int status;
  int numOfProduct;
  bool isFeatured;
  List<CategoryPackageModel>? categoryPackages;

  PackageModel({
    required this.id,
    required this.price,
    required this.imageUrl,
    required this.availableRentDays,
    required this.name,
    required this.description,
    required this.status,
    required this.numOfProduct,
    required this.isFeatured,
    this.categoryPackages,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json["id"],
        price: json["price"],
        imageUrl: json["imageUrl"] ?? '',
        availableRentDays: json["availableRentDays"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        numOfProduct: json["numOfProduct"],
        isFeatured: json["isFeatured"],
        categoryPackages: json["categoryPackages"] != null ? List<CategoryPackageModel>.from(json["categoryPackages"].map((x) => CategoryPackageModel.fromJson(x))) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "imageUrl": imageUrl,
        "availableRentDays": availableRentDays,
        "name": name,
        "description": description,
        "status": status,
        "numOfProduct": numOfProduct,
        "isFeatured": isFeatured,
        "categoryPackages": categoryPackages != null ? List<dynamic>.from(categoryPackages!.map((x) => x.toJson())) : null,
      };
}
