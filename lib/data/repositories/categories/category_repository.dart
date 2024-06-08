import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/category_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //Todo: Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await THttpHelper.get('categories');
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  //Todo: Get Subcategories
}
