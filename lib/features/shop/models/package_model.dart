class PackageModel {
  int id;
  int price;
  String name;
  String description;
  int status;
  List<CategoryPackage> categoryPackages;

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
        categoryPackages: List<CategoryPackage>.from(json["categoryPackages"].map((x) => CategoryPackage.fromJson(x))),
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

class CategoryPackage {
  int categoryId;
  String categoryName;
  int maxAvailableQuantity;

  CategoryPackage({
    required this.categoryId,
    required this.categoryName,
    required this.maxAvailableQuantity,
  });

  factory CategoryPackage.fromJson(Map<String, dynamic> json) => CategoryPackage(
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
