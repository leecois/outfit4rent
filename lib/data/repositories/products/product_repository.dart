import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

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

  Future<List<ProductModel>> getAllProducts({int page = 1, int limit = 50}) async {
    try {
      final response = await THttpHelper.get(
        'customers/products',
        queryParameters: {
          'page_index': page.toString(),
          'page_size': limit.toString(),
        },
      );

      if (response.containsKey('data')) {
        final List<dynamic> data = response['data'] as List<dynamic>;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Invalid API response format');
      }
    } catch (e) {
      if (e is TPlatformException) {
        throw TPlatformException(e.code).message;
      }
      throw 'An error occurred. Please try again later.';
    }
  }

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

  Future<List<ProductModel>> getFavoriteProducts(List<String> productIds) async {
    try {
      final response = await THttpHelper.get('customers/products', queryParameters: {'id': productIds});
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
