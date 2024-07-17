import 'package:outfit4rent/features/shop/models/category_package_model.dart';

class PackageModel {
  final int id;
  final int price;
  final String imageUrl;
  final int availableRentDays;
  final String name;
  final String description;
  final int status;
  final int numOfProduct;
  final bool isFeatured;
  final List<CategoryPackageModel>? categoryPackages;

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

  static PackageModel empty() => PackageModel(
        id: 0,
        price: 0,
        imageUrl: '',
        availableRentDays: 0,
        name: '',
        description: '',
        status: 0,
        numOfProduct: 0,
        isFeatured: false,
        categoryPackages: [],
      );

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
