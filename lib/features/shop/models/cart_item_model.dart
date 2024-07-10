class CartItemModel {
  final String packageId;
  final int price;
  final int availableRentDays;
  final String name;
  final String description;
  final int numOfProduct;
  final List<CreateItem> createItems;

  CartItemModel({
    required this.packageId,
    required this.price,
    required this.availableRentDays,
    required this.name,
    required this.description,
    required this.numOfProduct,
    required this.createItems,
  });

  static CartItemModel empty() => CartItemModel(
        packageId: '',
        price: 0,
        availableRentDays: 0,
        name: '',
        description: '',
        numOfProduct: 0,
        createItems: [],
      );
  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        packageId: json["packageId"],
        price: json["price"],
        availableRentDays: json["availableRentDays"],
        name: json["name"],
        description: json["description"],
        numOfProduct: json["numOfProduct"],
        createItems: (json["createItems"] as List).map((e) => CreateItem.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "packageId": packageId,
        "price": price,
        "availableRentDays": availableRentDays,
        "name": name,
        "description": description,
        "numOfProduct": numOfProduct,
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
  final String? imageUrl;

  CreateItem({
    required this.productId,
    this.name,
    this.size,
    this.deposit,
    this.price,
    required this.quantity,
    this.imageUrl,
  });

  static CreateItem empty() => CreateItem(
        productId: 0,
        quantity: 0,
      );
  factory CreateItem.fromJson(Map<String, dynamic> json) => CreateItem(
        productId: json["productId"],
        name: json["name"],
        size: json["size"],
        deposit: json["deposit"]?.toDouble(),
        price: json["price"],
        quantity: json["quantity"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "size": size,
        "deposit": deposit,
        "price": price,
        "quantity": quantity,
        "imageUrl": imageUrl,
      };
}
