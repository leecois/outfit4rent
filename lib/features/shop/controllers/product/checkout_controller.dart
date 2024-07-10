import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/list_title/payment_title.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/common/widgets/texts/section_heading.dart';
import 'package:outfit4rent/data/repositories/user/user_repository.dart';
import 'package:outfit4rent/features/personalization/controllers/user_controller.dart';
import 'package:outfit4rent/features/shop/models/payment_method_model.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/validators/validation.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;
  final userController = Get.put(UserController());
  final receiverName = TextEditingController();
  final receiverPhone = TextEditingController();
  final receiverAddress = TextEditingController();
  final walletId = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    selectedPaymentMethod.value = PaymentMethodModel(walletName: 'Visa', image: TImages.visa);
    initializeInfo();
  }

  Future<void> initializeInfo() async {
    await userController.fetchUserRecord();
    final user = userController.user.value;
    receiverName.text = user.name;
    receiverPhone.text = user.phone;
    receiverAddress.text = user.address ?? '';
  }

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
              TPaymentTitle(paymentMethod: PaymentMethodModel(walletName: 'Visa', image: TImages.visa)),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              TPaymentTitle(paymentMethod: PaymentMethodModel(walletName: 'Outfit4rent Wallet', image: TImages.logoIconDark)),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showUpdateAddressModal(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Update Address'),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(dialogContext).pop(),
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
                        onPressed: () => _handleUpdateAddress(dialogContext),
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
  }

  Future<void> _handleUpdateAddress(BuildContext context) async {
    try {
      final user = userController.user.value;
      user.name = receiverName.text;
      user.phone = receiverPhone.text;
      user.address = receiverAddress.text;
      await UserRepository.instance.updateUserDetail(user);
      userController.user.refresh();

      if (context.mounted) {
        Navigator.of(context).pop();
        TLoaders.successSnackBar(title: 'Address Updated', message: 'Your address has been updated successfully');
      }
    } catch (e) {
      if (context.mounted) {
        TLoaders.warningSnackBar(title: 'Address not updated', message: 'An error occurred. Please try again later.');
      }
    }
  }
}
