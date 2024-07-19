import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/list_title/payment_title.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/data/repositories/user/user_repository.dart';
import 'package:outfit4rent/data/repositories/wallet/wallet_repository.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/shop/models/payment_method_model.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/validators/validation.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;
  final userController = Get.put(UserController());
  final walletRepository = Get.put(WalletRepository());
  final receiverName = TextEditingController();
  final receiverPhone = TextEditingController();
  final receiverAddress = TextEditingController();
  final walletId = TextEditingController();

  RxList<PaymentMethodModel> wallets = <PaymentMethodModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    selectedPaymentMethod.value = PaymentMethodModel(walletName: 'Outfit4rent', image: TImages.logoIconDark);
    ever(userController.user, (_) => refreshWalletData());
  }

  Future<void> refreshWalletData() async {
    try {
      final customerId = userController.user.value.id;
      wallets.value = await walletRepository.getActiveWallet(customerId);
      if (wallets.isNotEmpty) {
        selectedPaymentMethod.value = wallets.first;
        walletId.text = selectedPaymentMethod.value.id?.toString() ?? '';
      } else {
        selectedPaymentMethod.value = PaymentMethodModel.empty();
        walletId.clear();
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to fetch wallets: $e');
    }
  }

  Future<void> loadUserData() async {
    try {
      await userController.fetchUserRecord();
      final user = userController.user.value;
      receiverName.text = user.name;
      receiverPhone.text = user.phone;
      receiverAddress.text = user.address ?? '';
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to load user data: $e');
    }
  }

  //Todo: Select Payment Method
  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(title: 'Select Payment Method', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwSections),
              ...wallets.map((wallet) => Column(
                    children: [
                      TPaymentTitle(paymentMethod: wallet),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //Todo: Update Selected Payment Method
  void updateSelectedPaymentMethod(PaymentMethodModel paymentMethod) {
    selectedPaymentMethod.value = paymentMethod;
    walletId.text = paymentMethod.id?.toString() ?? '';
  }

  //Todo: Show Update Address Modal
  Future<void> showUpdateAddressModal(BuildContext context) async {
    await loadUserData();
    if (!context.mounted) return; // Check if the context is still valid

    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog.fullscreen(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Update Address'),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: receiverName,
                          validator: (value) => TValidator.validateEmptyText('Full Name', value),
                          decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(MingCute.mailbox_line)),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TextFormField(
                          controller: receiverPhone,
                          validator: (value) => TValidator.validatePhoneNumber(value),
                          decoration: const InputDecoration(labelText: 'Phone', prefixIcon: Icon(MingCute.mailbox_line)),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TextFormField(
                          controller: receiverAddress,
                          validator: (value) => TValidator.validateEmptyText('Address', value),
                          decoration: const InputDecoration(labelText: 'Address', prefixIcon: Icon(MingCute.mailbox_line)),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await _handleUpdateAddress(context);
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> _handleUpdateAddress(BuildContext context) async {
    try {
      final user = userController.user.value;
      user.name = receiverName.text;
      user.phone = receiverPhone.text;
      user.address = receiverAddress.text;
      await UserRepository.instance.updateUserDetail(user);
      userController.user.refresh();

      if (context.mounted) {
        TLoaders.successSnackBar(title: 'Address Updated', message: 'Your address has been updated successfully');
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        TLoaders.warningSnackBar(title: 'Address not updated', message: 'An error occurred. Please try again later.');
      }
      return false;
    }
  }
}
