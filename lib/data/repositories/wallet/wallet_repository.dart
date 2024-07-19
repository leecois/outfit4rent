import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/features/personalization/models/transaction_model.dart';
import 'package:outfit4rent/features/shop/models/payment_method_model.dart';
import 'package:outfit4rent/utils/exceptions/firebase_exceptions.dart';
import 'package:outfit4rent/utils/exceptions/platform_exceptions.dart';
import 'package:outfit4rent/utils/http/http_client.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletRepository extends GetxController {
  static WalletRepository get instance => Get.find();

  // Todo: Get wallet of a user
  Future<List<PaymentMethodModel>> getActiveWallet(int customerId) async {
    try {
      final response = await THttpHelper.get('customers/$customerId/wallets/actived-wallets');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => PaymentMethodModel.fromJson(json)).toList();
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      debugPrint('TPlatformException: ${e.message}');
      throw TPlatformException(e.code).message;
    } catch (e) {
      debugPrint('Error: $e');
      throw 'An error occurred. Please try again later.';
    }
  }

  // Todo: Add money to wallet
  Future<void> addMoneyToWallet(int userId, double amount) async {
    try {
      final response = await THttpHelper.getRaw('online-payments/users/$userId/money/$amount');
      debugPrint('API Response: $response');

      // Assuming the response is a direct URL string
      final String redirectUrl = response.toString().trim();
      debugPrint('Redirect URL: $redirectUrl');

      // Use url_launcher to open the URL
      final Uri uri = Uri.parse(redirectUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $redirectUrl';
      }
    } on FormatException catch (e) {
      debugPrint('FormatException: ${e.message}');
      throw 'Invalid response format from server';
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      debugPrint('TPlatformException: ${e.message}');
      throw TPlatformException(e.code).message;
    } catch (e) {
      debugPrint('Error: $e');
      throw 'An error occurred. Please try again later.';
    }
  }

  //Todo: Fetch history of wallet transactions
  Future<List<TransactionModel>> getTransactionHistory(int customerId) async {
    try {
      final response = await THttpHelper.get('transactions/customers/$customerId');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => TransactionModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      throw 'An error occurred while fetching transaction history.';
    }
  }
}
