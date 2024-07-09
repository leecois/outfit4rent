class BrandModel {
  final int id;
  final String name;
  final String url;
  final String description;
  final int status;
  final bool isFeatured;

  BrandModel({
    required this.id,
    required this.name,
    required this.url,
    required this.description,
    required this.status,
    required this.isFeatured,
  });

  //Todo: Empty Helper Function
  static BrandModel empty() => BrandModel(id: 0, name: '', url: '', description: '', status: 0, isFeatured: false);

  //Todo: Convert BrandModel to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "description": description,
        "status": status,
        "isFeatured": isFeatured,
      };
  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        description: json["description"],
        status: json["status"],
        isFeatured: json["isFeatured"],
      );
}
