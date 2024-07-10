class OrderModel {
  final int id;
  final int customerId;
  final int packageId;
  final String packageName;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int price;
  final String receiverName;
  final String receiverPhone;
  final String receiverAddress;
  final int status;
  final int transactionId;
  final int quantityOfItems;
  final int totalDeposit;
  final List<ItemInUserModel> itemInUsers;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.packageId,
    required this.packageName,
    required this.dateFrom,
    required this.dateTo,
    required this.price,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.status,
    required this.transactionId,
    required this.quantityOfItems,
    required this.totalDeposit,
    required this.itemInUsers,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'],
        customerId: json['customerId'],
        packageId: json['packageId'],
        packageName: json['packageName'],
        dateFrom: DateTime.parse(json['dateFrom']),
        dateTo: DateTime.parse(json['dateTo']),
        price: json['price'],
        receiverName: json['receiverName'],
        receiverPhone: json['receiverPhone'],
        receiverAddress: json['receiverAddress'],
        status: json['status'],
        transactionId: json['transactionId'],
        quantityOfItems: json['quantityOfItems'],
        totalDeposit: json['totalDeposit'],
        itemInUsers: (json['itemInUsers'] as List)
            .map((e) => ItemInUserModel.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'customerId': customerId,
        'packageId': packageId,
        'packageName': packageName,
        'dateFrom': dateFrom.toIso8601String(),
        'dateTo': dateTo.toIso8601String(),
        'price': price,
        'receiverName': receiverName,
        'receiverPhone': receiverPhone,
        'receiverAddress': receiverAddress,
        'status': status,
        'transactionId': transactionId,
        'quantityOfItems': quantityOfItems,
        'totalDeposit': totalDeposit,
        'itemInUsers': itemInUsers.map((e) => e.toJson()).toList(),
      };
}

class ItemInUserModel {
  final int id;
  final int deposit;
  final int status;
  final int productId;
  final int userPackageId;
  final DateTime dateGive;
  final DateTime dateReceive;
  final int tornMoney;
  final int quantity;

  ItemInUserModel({
    required this.id,
    required this.deposit,
    required this.status,
    required this.productId,
    required this.userPackageId,
    required this.dateGive,
    required this.dateReceive,
    required this.tornMoney,
    required this.quantity,
  });

  factory ItemInUserModel.fromJson(Map<String, dynamic> json) => ItemInUserModel(
        id: json['id'],
        deposit: json['deposit'],
        status: json['status'],
        productId: json['productId'],
        userPackageId: json['userPackageId'],
        dateGive: DateTime.parse(json['dateGive']),
        dateReceive: DateTime.parse(json['dateReceive']),
        tornMoney: json['tornMoney'],
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'deposit': deposit,
        'status': status,
        'productId': productId,
        'userPackageId': userPackageId,
        'dateGive': dateGive.toIso8601String(),
        'dateReceive': dateReceive.toIso8601String(),
        'tornMoney': tornMoney,
        'quantity': quantity,
      };
}
