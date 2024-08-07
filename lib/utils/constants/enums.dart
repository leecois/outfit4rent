/* --
      LIST OF Enums
      They cannot be created inside a class.
-- */

import 'package:flutter/material.dart';
import 'package:outfit4rent/utils/constants/colors.dart';

/// Switch of Custom Brand-Text-Size Widget
enum TextSizes { small, medium, large }

enum OrderStatus { canceled, processing, renting, expired }

extension OrderStatusExtension on OrderStatus {
  static OrderStatus fromInt(int status) {
    switch (status) {
      case -1:
        return OrderStatus.canceled;
      case 0:
        return OrderStatus.processing;
      case 1:
        return OrderStatus.renting;
      case 2:
        return OrderStatus.expired;
      default:
        throw Exception('Invalid order status');
    }
  }

  String get name {
    switch (this) {
      case OrderStatus.canceled:
        return "Canceled";
      case OrderStatus.processing:
        return "Processing";
      case OrderStatus.renting:
        return "Renting";
      case OrderStatus.expired:
        return "Expired";
      default:
        return "";
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.canceled:
        return TColors.error;
      case OrderStatus.processing:
        return TColors.warning;
      case OrderStatus.renting:
        return TColors.info;
      case OrderStatus.expired:
        return TColors.primary;
      default:
        return TColors.black;
    }
  }
}

enum PaymentMethods { paypal, googlePay, applePay, visa, masterCard, creditCard, paystack, razorPay, paytm }
