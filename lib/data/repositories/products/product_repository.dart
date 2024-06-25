import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // Get featured products limit 4
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final response = await THttpHelper.get('customers/products', queryParameters: {
        'is_featured': 'true',
      });
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

  // Get all products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await THttpHelper.get('customers/products');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

  // Get details of a product
  Future<ProductModel> getProductDetails(int productId) async {
    try {
      final response = await THttpHelper.get('products/$productId');
      final Map<String, dynamic> data = response['data'] as Map<String, dynamic>;
      return ProductModel.fromJson(data);
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

  // Fetch products with query parameters
  Future<List<ProductModel>> fetchProductsByQuery(Map<String, dynamic> query) async {
    try {
      final response = await THttpHelper.get('customers/products', queryParameters: query);
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }
}
