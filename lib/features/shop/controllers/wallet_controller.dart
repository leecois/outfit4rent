import 'package:get/get.dart';
import 'package:outfit4rent/data/repositories/wallet/wallet_repository.dart';

class WalletController extends GetxController {
  static WalletController get instance => Get.find();

  RxBool isLoading = false.obs;
  final walletRepository = Get.put(WalletRepository());

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
}
