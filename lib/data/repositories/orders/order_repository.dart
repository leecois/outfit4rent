import 'package:get/get.dart';
import 'package:outfit4rent/features/shop/models/order_model.dart';
import 'package:outfit4rent/features/shop/models/order_request_model.dart';
import 'package:outfit4rent/utils/http/http_client.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  Future<List<OrderModel>> fetchUserOrders(int customerId) async {
    try {
      final response = await THttpHelper.get('orders/customers/$customerId');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return data.map((json) => OrderModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch user orders: $e');
    }
  }

  Future<void> saveOrder(int customerId, int packageId, OrderRequestModel order) async {
    try {
      await THttpHelper.post(
        'orders/customers/$customerId/packages/$packageId',
        order.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to save order');
    }
  }
}
