import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/category_package_model.dart';
import 'package:outfit4rent/features/shop/models/package_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class PackageRepository extends GetxController {
  static PackageRepository get instance => Get.find();

  // Get all packages
  Future<List<PackageModel>> getAllPackages() async {
    try {
      final response = await THttpHelper.get('packages');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => PackageModel.fromJson(json)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  // Get categories for a specific package
  Future<List<CategoryPackageModel>> getCategoryPackages(int packageId) async {
    try {
      final response = await THttpHelper.get('category-packages/by-package-id/$packageId');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => CategoryPackageModel.fromJson(json)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }
}
