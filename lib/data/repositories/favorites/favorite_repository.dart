import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class FavoriteRepository extends GetxController {
  static FavoriteRepository get instance => Get.find();

  // Get all favorite products
  Future<List<ProductModel>> getFavoriteProducts(int customerId) async {
    try {
      final response = await THttpHelper.get('customers/$customerId/favorited-product');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  // Add product to favorite
  Future<void> addFavoriteProduct(int customerId, int productId) async {
    try {
      await THttpHelper.post('customers/$customerId/favorited-products/$productId', {});
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  // Remove product from favorite
  Future<void> removeFavoriteProduct(int customerId, int productId) async {
    try {
      await THttpHelper.delete('customers/$customerId/favorited-products/$productId');
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }
}
