import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/shop/controllers/wallet_controller.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final walletController = Get.put(WalletController());
    final user = Get.put(UserController());
    final TextEditingController amountController = TextEditingController();

    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Add Money')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.money_4_outline), labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final double amount = double.parse(amountController.text);
                    // Replace with the actual user ID
                    int userId = user.user.value.id;
                    await walletController.addMoney(userId, amount);
                  },
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
