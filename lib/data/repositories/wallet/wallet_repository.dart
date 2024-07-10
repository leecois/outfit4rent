import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/payment_method_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class WalletRepository extends GetxController {
  static WalletRepository get instance => Get.find();

  //Todo: Get wallet of a user
  Future<List<PaymentMethodModel>> getActiveWallet(int customerId) async {
    try {
      final response = await THttpHelper.get('customers/$customerId/wallets/actived-wallets');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => PaymentMethodModel.fromJson(json)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again later.';
    }
  }

  //Todo: Create a new wallet
}
