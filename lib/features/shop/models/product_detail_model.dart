class ProductDetailModel {
  int id;
  String name;
  int price;
  String size;
  int deposit;
  String description;
  int status;
  bool isUsed;
  Category category;
  Brand brand;
  int quantity;
  int availableQuantity;
  String type;
  List<ProductImage> images;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.deposit,
    required this.description,
    required this.status,
    required this.isUsed,
    required this.category,
    required this.brand,
    required this.quantity,
    required this.availableQuantity,
    required this.type,
    required this.images,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        size: json["size"],
        deposit: json["deposit"],
        description: json["description"],
        status: json["status"],
        isUsed: json["isUsed"] == "True",
        category: Category.fromJson(json["category"]),
        brand: Brand.fromJson(json["brand"]),
        quantity: json["quantity"],
        availableQuantity: json["availableQuantity"],
        type: json["type"],
        images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "size": size,
        "deposit": deposit,
        "description": description,
        "status": status,
        "isUsed": isUsed ? "True" : "False",
        "category": category.toJson(),
        "brand": brand.toJson(),
        "quantity": quantity,
        "availableQuantity": availableQuantity,
        "type": type,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Brand {
  int id;
  String name;

  Brand({
    required this.id,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ProductImage {
  int id;
  String link;

  ProductImage({
    required this.id,
    required this.link,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
      };
}
