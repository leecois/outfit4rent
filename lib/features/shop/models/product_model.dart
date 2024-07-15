class ImageModel {
  final int id;
  final String url;
  final int idProduct;

  ImageModel({
    required this.id,
    required this.url,
    required this.idProduct,
  });

  static ImageModel empty() => ImageModel(id: 0, url: '', idProduct: 0);

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        url: json["url"] ?? '',
        idProduct: json["idProduct"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "idProduct": idProduct,
      };
}

class ProductModel {
  final int id;
  final String name;
  final int price;
  final String size;
  final double deposit;
  final String description;
  final int status;
  final String isUsed;
  final int idCategory;
  final int quantity;
  final int availableQuantity;
  final int idBrand;
  final String type;
  final bool isFeatured;
  final List<ImageModel> images;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.deposit,
    required this.description,
    required this.status,
    required this.isUsed,
    required this.idCategory,
    required this.quantity,
    required this.availableQuantity,
    required this.idBrand,
    required this.type,
    required this.isFeatured,
    required this.images,
  });

  static ProductModel empty() => ProductModel(
        id: 0,
        name: '',
        price: 0,
        size: '',
        deposit: 0,
        description: '',
        status: 0,
        isUsed: '',
        idCategory: 0,
        quantity: 0,
        availableQuantity: 0,
        idBrand: 0,
        type: '',
        isFeatured: false,
        images: [],
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        price: json["price"] ?? 0,
        size: json["size"] ?? '',
        deposit: (json["deposit"] as num?)?.toDouble() ?? 0.0,
        description: json["description"] ?? '',
        status: json["status"] ?? 0,
        isUsed: json["isUsed"] ?? '',
        idCategory: json["idCategory"] ?? 0,
        quantity: json["quantity"] ?? 0,
        availableQuantity: json["availableQuantity"] ?? 0,
        idBrand: json["idBrand"] ?? 0,
        type: json["type"] ?? '',
        isFeatured: json["isFeatured"] ?? false,
        images: (json["images"] as List<dynamic>).map((image) => ImageModel.fromJson(image as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "size": size,
        "deposit": deposit,
        "description": description,
        "status": status,
        "isUsed": isUsed,
        "idCategory": idCategory,
        "quantity": quantity,
        "availableQuantity": availableQuantity,
        "idBrand": idBrand,
        "type": type,
        "isFeatured": isFeatured,
        "images": images.map((e) => e.toJson()).toList(),
      };
}
