import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/common/widgets/success/success_screen.dart';
import 'package:outfit4rent/data/repositories/orders/order_repository.dart';
import 'package:outfit4rent/features/shop/controllers/product/cart_controller.dart';
import 'package:outfit4rent/features/shop/controllers/product/product_controller.dart';
import 'package:outfit4rent/features/shop/models/order_model.dart';
import 'package:outfit4rent/features/shop/models/order_request_model.dart';
import 'package:outfit4rent/navigation_menu.dart';
import 'package:outfit4rent/utils/constants/image_strings.dart';
import 'package:outfit4rent/utils/local_storage/storage_utility.dart';
import 'package:outfit4rent/utils/popups/full_screen_loader.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final orderRepository = Get.put(OrderRepository());
  final productController = Get.put(ProductController());

  RxList<OrderModel> userOrders = <OrderModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    try {
      isLoading.value = true;
      final customerId = _getCustomerId();
      if (customerId == null) {
        // No logged-in user, clear the orders list
        userOrders.clear();
        return;
      }
      final orders = await orderRepository.fetchUserOrders(customerId);
      userOrders.assignAll(orders);
      await _fetchProductDetails();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Failed to fetch orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchProductDetails() async {
    for (var order in userOrders) {
      for (var item in order.itemInUsers) {
        await productController.fetchProductDetail(item.productId);
      }
    }
  }

  void refreshOrders() {
    fetchUserOrders();
  }

  Future<void> processOrder(DateTime dateFrom, String receiverName, String receiverPhone, String receiverAddress, int walletId) async {
    try {
      final customerId = _getCustomerId();
      if (customerId == null) {
        throw Exception('User not logged in. Please log in to continue.');
      }

      _validateOrderInputs(dateFrom, receiverName, receiverPhone, receiverAddress, walletId);

      TFullScreenLoader.openLoadingDialog('Processing your order...', TImages.animation7);

      final packageId = _getSelectedPackageId();
      final order = _createOrderRequestModel(dateFrom, receiverName, receiverPhone, receiverAddress, walletId);

      await orderRepository.saveOrder(customerId, packageId, order);
      _handleOrderSuccess();
    } catch (e) {
      _handleError('Failed to place order', e);
    }
  }

  int? _getCustomerId() {
    return TLocalStorage.instance().readData<int>('currentUser');
  }

  int _getSelectedPackageId() {
    final packageId = int.tryParse(cartController.selectedPackage.value?.packageId ?? '0');
    if (packageId == null || packageId == 0) {
      throw Exception('No package selected. Please select a package before proceeding.');
    }
    return packageId;
  }

  void _validateOrderInputs(DateTime dateFrom, String receiverName, String receiverPhone, String receiverAddress, int walletId) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (dateFrom.isBefore(today)) {
      throw Exception('Invalid date. Please select today or a future date.');
    }
    if (receiverName.isEmpty) {
      throw Exception('Receiver name is required.');
    }
    if (receiverPhone.isEmpty) {
      throw Exception('Receiver phone is required.');
    }
    if (receiverAddress.isEmpty) {
      throw Exception('Receiver address is required.');
    }
    if (walletId <= 0) {
      throw Exception('Invalid wallet selected. Please choose a valid payment method.');
    }
    if (cartController.cartItems.isEmpty) {
      throw Exception('Your cart is empty. Please add items before placing an order.');
    }
  }

  OrderRequestModel _createOrderRequestModel(DateTime dateFrom, String receiverName, String receiverPhone, String receiverAddress, int walletId) {
    final order = OrderRequestModel(
      dateFrom: dateFrom,
      receiverName: receiverName,
      receiverPhone: receiverPhone,
      receiverAddress: receiverAddress,
      walletId: walletId,
      createItems: cartController.cartItems.expand((cartItem) => cartItem.createItems).toList(),
    );
    if (kDebugMode) {
      print('Order Request: $order');
    }
    return order;
  }

  void _handleOrderSuccess() {
    cartController.clearCart();
    Get.off(() => SuccessScreen(
          image: TImages.lightAppLogo,
          title: 'Thank you!',
          subtitle: 'Your order has been placed successfully',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ));
  }

  void _handleError(String message, dynamic error) {
    TLoaders.errorSnackBar(title: message, message: error.toString());
    throw Exception('$message: $error');
  }
}
