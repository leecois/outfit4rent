class ProductModel {
  int id;
  String name;
  int price;
  String size;
  int deposit;
  String description;
  String status;
  String category;
  String brand;
  String type;
  String imgUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.deposit,
    required this.description,
    required this.status,
    required this.category,
    required this.brand,
    required this.type,
    required this.imgUrl,
  });

  static ProductModel empty() => ProductModel(id: 0, name: '', price: 0, size: '', deposit: 0, description: '', status: '', category: '', brand: '', type: '', imgUrl: '');

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"] ?? '',
        price: json["price"] ?? 0,
        size: json["size"] ?? '',
        deposit: json["deposit"] ?? 0,
        description: json["description"] ?? '',
        status: json["status"] ?? '',
        category: json["category"] ?? '',
        brand: json["brand"] ?? '',
        type: json["type"] ?? '',
        imgUrl: json["imgUrl"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "size": size,
        "deposit": deposit,
        "description": description,
        "status": status,
        "category": category,
        "brand": brand,
        "type": type,
        "imgUrl": imgUrl,
      };
}
