import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:outfit4rent/features/shop/controllers/wallet_controller.dart';

class TransactionHistoryWidget extends StatelessWidget {
  final int customerId;

  TransactionHistoryWidget({super.key, required this.customerId});

  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    controller.fetchTransactionHistory(customerId);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.transactions.isEmpty) {
        return const Center(child: Text('No transactions found'));
      } else {
        return ListView.builder(
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final transaction = controller.transactions[index];
            return ListTile(
              title: Text('${transaction.paymethod} - ${transaction.amount}'),
              subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(transaction.dateTransaction)),
              trailing: Text(transaction.status == 0 ? 'Failed' : 'Completed'),
            );
          },
        );
      }
    });
  }
}
