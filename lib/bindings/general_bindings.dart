import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/controllers/product/cart_controller.dart';
import 'package:outfit4rent/features/shop/controllers/product/checkout_controller.dart';
import 'package:outfit4rent/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(CartController());
    Get.put(CheckoutController());
  }
}
