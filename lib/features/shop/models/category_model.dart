class CategoryModel {
  final int id;
  final String name;
  final String description;
  final int status;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  //Todo: Empty Helper Function
  static CategoryModel empty() => CategoryModel(id: 0, name: '', description: '', status: 0);

  // Convert CategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}
