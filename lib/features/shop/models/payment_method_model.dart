import 'package:outfit4rent/utils/constants/image_strings.dart';

class PaymentMethodModel {
  final int? id;
  final String image;
  final String? walletCode;
  final String walletName;
  final int? status;
  final int? customerId;

  PaymentMethodModel({
    this.id,
    this.walletCode,
    required this.walletName,
    required this.image,
    this.status,
    this.customerId,
  });
  static PaymentMethodModel empty() {
    return PaymentMethodModel(
      id: 0,
      walletCode: '',
      walletName: '',
      status: 0,
      image: '',
      customerId: 0,
    );
  }

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      walletCode: json['walletCode'],
      walletName: json['walletName'],
      status: json['status'],
      image: TImages.logoIconDark,
      customerId: json['customerId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'walletCode': walletCode,
        'walletName': walletName,
        'status': status,
        'image': image,
        'customerId': customerId,
      };
}
