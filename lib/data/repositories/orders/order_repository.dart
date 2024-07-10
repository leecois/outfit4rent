import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/order_model.dart';
import 'package:outfit4rent/features/shop/models/order_request_model.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  Future<List<OrderModel>> fetchUserOrders(int customerId) async {
    try {
      final response = await THttpHelper.get('orders/customers/$customerId');
      return (response as List).map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch user orders: $e');
    }
  }

  Future<void> saveOrder(int customerId, int packageId, OrderRequestModel order) async {
    try {
      final response = await THttpHelper.post(
        'orders/customers/$customerId/packages/$packageId',
        order.toJson(),
      );
      print('Order save response: $response');
    } catch (e) {
      print('Failed to save order: $e');
      throw Exception('Failed to save order: $e');
    }
  }
}
