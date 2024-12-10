import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';

class ContactInfo {
  String phone;
  String address;

  ContactInfo({required this.phone, required this.address});

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'address': address,
    };
  }

  ContactInfo copyWith({String? phone, String? address}) {
    return ContactInfo(
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}

class PaymentInfo {
  String paymentMethod;

  PaymentInfo({this.paymentMethod = PaymentMethods.cash});

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      paymentMethod: json['paymentMethod'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentMethod': paymentMethod,
    };
  }

  PaymentInfo copyWith({String? paymentMethod, CardEntity? card}) {
    return PaymentInfo(
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

class OrderItemsInfo {
  double totalPrice;
  List<CartItemProductEntity> orderItems;

  OrderItemsInfo({required this.totalPrice, required this.orderItems});

  factory OrderItemsInfo.fromJson(Map<String, dynamic> json) {
    return OrderItemsInfo(
      totalPrice: json['totalPrice'] ?? 0.0,
      orderItems: (json['orderItems'] as List?)
              ?.map((item) => CartItemProductEntity.fromJson(item))
              .toList() ??
          [],
    );
  }

  // toJson method for OrderItemsInfo
  Map<String, dynamic> toJson() {
    return {
      'totalPrice': totalPrice,
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
    };
  }

  OrderItemsInfo copyWith(
      {double? totalPrice, List<CartItemProductEntity>? orderItems}) {
    return OrderItemsInfo(
      totalPrice: totalPrice ?? this.totalPrice,
      orderItems: orderItems ?? this.orderItems,
    );
  }
}

class CheckoutData {
  String shopGuid;
  ContactInfo contactInfo;
  PaymentInfo paymentInfo;
  OrderItemsInfo orderItemsInfo;

  CheckoutData(
      {required this.shopGuid,
      required this.contactInfo,
      required this.paymentInfo,
      required this.orderItemsInfo});

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    return CheckoutData(
      shopGuid: json['shopGuid'],
      contactInfo: ContactInfo.fromJson(json['contactInfo'] ?? {}),
      paymentInfo: PaymentInfo.fromJson(json['paymentInfo'] ?? {}),
      orderItemsInfo: OrderItemsInfo.fromJson(json['orderItemsInfo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shopGuid': shopGuid,
      'contactInfo': contactInfo.toJson(),
      'paymentInfo': paymentInfo.toJson(),
      'orderItemsInfo': orderItemsInfo.toJson(),
    };
  }

  CheckoutData copyWith({
    String? shopGuid,
    ContactInfo? contactInfo,
    PaymentInfo? paymentInfo,
    OrderItemsInfo? orderItemsInfo,
  }) {
    return CheckoutData(
      shopGuid: shopGuid ?? this.shopGuid,
      contactInfo: contactInfo ?? this.contactInfo,
      paymentInfo: paymentInfo ?? this.paymentInfo,
      orderItemsInfo: orderItemsInfo ?? this.orderItemsInfo,
    );
  }
}
