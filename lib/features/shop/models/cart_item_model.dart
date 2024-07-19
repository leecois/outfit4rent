import 'package:outfit4rent/features/shop/models/category_package_model.dart';

class CartItemModel {
  final String packageId;
  final int price;
  final int availableRentDays;
  final String name;
  final String description;
  final int numOfProduct;
  final List<CategoryPackageModel> categoryPackages;
  final List<CreateItem> createItems;

  CartItemModel({
    required this.packageId,
    required this.price,
    required this.availableRentDays,
    required this.name,
    required this.description,
    required this.numOfProduct,
    required this.categoryPackages,
    required this.createItems,
  });

  double getTotalPrice() {
    double totalDeposit = createItems.fold(0, (sum, item) => sum + (item.deposit ?? 0) * item.quantity);
    return totalDeposit * price;
  }

  static CartItemModel empty() => CartItemModel(
        packageId: '',
        price: 0,
        availableRentDays: 0,
        name: '',
        description: '',
        numOfProduct: 0,
        categoryPackages: [],
        createItems: [],
      );
  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        packageId: json["packageId"] ?? '',
        price: json["price"] ?? 0,
        availableRentDays: json["availableRentDays"] ?? 0,
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        numOfProduct: json["numOfProduct"] ?? 0,
        categoryPackages: (json["categoryPackages"] as List?)?.map((e) => CategoryPackageModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
        createItems: (json["createItems"] as List?)?.map((e) => CreateItem.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        "packageId": packageId,
        "price": price,
        "availableRentDays": availableRentDays,
        "name": name,
        "description": description,
        "numOfProduct": numOfProduct,
        "categoryPackages": categoryPackages.map((e) => e.toJson()).toList(),
        "createItems": createItems.map((e) => e.toJson()).toList(),
      };
}

class CreateItem {
  final int productId;
  final String? name;
  final String? size;
  final double? deposit;
  final int? price;
  final int quantity;
  final int idCategory;
  final String? imageUrl;

  CreateItem({
    required this.productId,
    this.name,
    this.size,
    this.deposit,
    this.price,
    required this.quantity,
    required this.idCategory,
    this.imageUrl,
  });

  static CreateItem empty() => CreateItem(
        productId: 0,
        quantity: 0,
        idCategory: 0,
      );

  factory CreateItem.fromJson(Map<String, dynamic> json) => CreateItem(
        productId: json["productId"],
        name: json["name"],
        size: json["size"],
        deposit: json["deposit"]?.toDouble(),
        price: json["price"],
        quantity: json["quantity"],
        idCategory: json["idCategory"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "size": size,
        "deposit": deposit,
        "price": price,
        "quantity": quantity,
        "idCategory": idCategory,
        "imageUrl": imageUrl,
      };
}
