import 'package:get/get.dart';
import 'package:outfit4rent/data/repositories/wallet/wallet_repository.dart';
import 'package:outfit4rent/features/personalization/models/transaction_model.dart';

class WalletController extends GetxController {
  static WalletController get instance => Get.find();

  final walletRepository = Get.put(WalletRepository());
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> addMoney(int userId, double amount) async {
    try {
      isLoading.value = true;
      await walletRepository.addMoneyToWallet(userId, amount);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTransactionHistory(int customerId) async {
    try {
      isLoading.value = true;
      List<TransactionModel> fetchedTransactions = await walletRepository.getTransactionHistory(customerId);

      fetchedTransactions.sort((a, b) => b.dateTransaction.compareTo(a.dateTransaction));
      transactions.value = fetchedTransactions;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
