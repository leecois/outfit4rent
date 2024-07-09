class BrandCategoryModel {
  final int brandId;
  final int categoryId;

  BrandCategoryModel({required this.brandId, required this.categoryId});

  //Todo: Empty Helper Function
  static BrandCategoryModel empty() => BrandCategoryModel(brandId: 0, categoryId: 0);

  //Todo: Convert BrandCategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': {'idBrand': brandId, 'idCategory': categoryId}
    };
  }

  factory BrandCategoryModel.fromJson(Map<String, dynamic> json) {
    return BrandCategoryModel(
      brandId: json['idBrand'] ?? 0,
      categoryId: json['idCategory'] ?? 0,
    );
  }
}
