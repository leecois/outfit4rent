import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/success/success_screen.dart';
import 'package:outfit4rent/data/repositories/orders/order_repository.dart';
import 'package:outfit4rent/features/shop/controllers/product/cart_controller.dart';
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

  Future<List<OrderModel>> fetchUserOrders(int customerId) async {
    try {
      return await orderRepository.fetchUserOrders(customerId);
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  Future<void> processOrder(DateTime dateFrom, String receiverName, String receiverPhone, String receiverAddress, int walletId) async {
    try {
      // Show loading dialog
      TFullScreenLoader.openLoadingDialog('Processing your order...', TImages.animation7);

      final customerId = TLocalStorage.instance().readData<int>('currentUser');
      if (customerId == null) {
        throw Exception('Customer ID not found in local storage.');
      }

      final packageId = int.parse(cartController.selectedPackage.value?.packageId ?? '0');
      if (packageId == 0) {
        throw Exception('No package selected.');
      }

      final order = OrderRequestModel(
        dateFrom: dateFrom,
        receiverName: receiverName,
        receiverPhone: receiverPhone,
        receiverAddress: receiverAddress,
        walletId: walletId,
        createItems: cartController.cartItems.expand((cartItem) => cartItem.createItems).toList(),
      );

      // Save order to database
      await orderRepository.saveOrder(customerId, packageId, order);

      // Update the cart status
      cartController.clearCart();

      // Show success screen
      Get.off(() => SuccessScreen(
            image: TImages.animation3,
            title: 'Thank you!',
            subtitle: 'Your order has been placed successfully',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
    } catch (e) {
      // Log the error message

      throw Exception('Failed to place order: $e');
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
