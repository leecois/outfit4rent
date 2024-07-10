import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/features/shop/controllers/product/cart_controller.dart';
import 'package:outfit4rent/features/shop/controllers/product/order_controller.dart';
import 'package:outfit4rent/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:outfit4rent/features/shop/screens/cart/widgets/cart_package_section.dart';
import 'package:outfit4rent/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:outfit4rent/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:outfit4rent/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:outfit4rent/utils/constants/colors.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/helper_functions.dart';
import 'package:outfit4rent/utils/helpers/pricing_calculator.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _receiverNameController = TextEditingController();
  final _receiverPhoneController = TextEditingController();
  final _receiverAddressController = TextEditingController();
  final _walletIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'VN');
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: TAppBar(showBackArrow: true, title: Text('Checkout', style: Theme.of(context).textTheme.headlineSmall)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                // Todo: Package Selected
                const TCartPackageSection(showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),
                // Todo: Items in Cart
                const TCartItems(
                  showAddRemoveButton: false,
                  physics: NeverScrollableScrollPhysics(),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                //Todo: Billing Section
                TRoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: dark ? TColors.black : TColors.white,
                  child: Column(
                    children: [
                      //Todo: Pricing
                      const TBillingAmountSection(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      //Todo: Divider
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      //Todo: Payment Method
                      const TBillingPaymentSection(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      //Todo: Address
                      const TBillingAddressSection(),

                      // Receiver Name
                      TextField(
                        controller: _receiverNameController,
                        decoration: const InputDecoration(labelText: 'Receiver Name'),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Receiver Phone
                      TextField(
                        controller: _receiverPhoneController,
                        decoration: const InputDecoration(labelText: 'Receiver Phone'),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Receiver Address
                      TextField(
                        controller: _receiverAddressController,
                        decoration: const InputDecoration(labelText: 'Receiver Address'),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Wallet ID
                      TextField(
                        controller: _walletIdController,
                        decoration: const InputDecoration(labelText: 'Wallet ID'),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: subTotal > 0
                ? () {
                    final dateFrom = DateTime.now();
                    final receiverName = _receiverNameController.text;
                    final receiverPhone = _receiverPhoneController.text;
                    final receiverAddress = _receiverAddressController.text;
                    final walletId = int.tryParse(_walletIdController.text) ?? 0;

                    if (receiverName.isEmpty || receiverPhone.isEmpty || receiverAddress.isEmpty || walletId == 0) {
                      TLoaders.warningSnackBar(title: 'Incomplete Information', message: 'Please fill in all the required fields');
                      return;
                    }

                    orderController.processOrder(dateFrom, receiverName, receiverPhone, receiverAddress, walletId);
                  }
                : () => TLoaders.warningSnackBar(title: 'Cart is empty', message: 'Please add items to cart'),
            child: Text('Place Order \$$totalAmount'),
          ),
        ));
  }

  @override
  void dispose() {
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    _receiverAddressController.dispose();
    _walletIdController.dispose();
    super.dispose();
  }
}
