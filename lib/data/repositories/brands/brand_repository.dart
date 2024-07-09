import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/brand_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  //Todo: Get all brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final response = await THttpHelper.get('brands');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => BrandModel.fromJson(json)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }
}
