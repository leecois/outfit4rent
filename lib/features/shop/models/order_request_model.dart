import 'package:outfit4rent/features/shop/models/cart_item_model.dart';

class OrderRequestModel {
  final DateTime dateFrom;
  final String receiverName;
  final String receiverPhone;
  final String receiverAddress;
  final int walletId;
  final List<CreateItem> createItems;

  OrderRequestModel({
    required this.dateFrom,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.walletId,
    required this.createItems,
  });

  Map<String, dynamic> toJson() => {
        "dateFrom": dateFrom.toIso8601String(),
        "receiverName": receiverName,
        "receiverPhone": receiverPhone,
        "receiverAddress": receiverAddress,
        "walletId": walletId,
        "createItems": createItems.map((item) => item.toJson()).toList(),
      };
}
