import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  //Todo: Empty Helper Function
  static CategoryModel empty() => CategoryModel(id: '', image: '', name: '', isFeatured: false);

  //Todo: Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ParentId': parentId,
    };
  }

  //Todo: Map JSON structure to User model
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      //Todo: Map JSON structure to User model
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
