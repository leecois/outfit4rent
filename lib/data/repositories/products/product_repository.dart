import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/product_detail_model.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  //Todo: Get all products
  Future<List<ProductModel>> getAllProduct() async {
    try {
      final response = await THttpHelper.get('products');
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

  //Todo: Get featured product
  //Todo: Get details of a product
  Future<ProductDetailModel> getProductDetails(int productId) async {
    try {
      final response = await THttpHelper.get('product/$productId');
      final Map<String, dynamic> data = response['data'] as Map<String, dynamic>;

      return ProductDetailModel.fromJson(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }
}
