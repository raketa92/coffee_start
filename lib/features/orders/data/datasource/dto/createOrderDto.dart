// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coffee_start/features/card/domain/entities/card.dart';

class CartProductDto {
  final int quantity;
  final String productGuid;

  CartProductDto({required this.quantity, required this.productGuid});

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'productGuid': productGuid,
    };
  }
}

class CreateOrderDto {
  String? userGuid;
  String shopGuid;
  String phone;
  String address;
  String paymentMethod;
  CardEntity? card;
  double totalPrice;
  List<CartProductDto> orderItems;

  CreateOrderDto({
    this.userGuid,
    required this.shopGuid,
    required this.phone,
    required this.address,
    required this.paymentMethod,
    this.card,
    required this.totalPrice,
    required this.orderItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'userGuid': userGuid,
      'shopGuid': shopGuid,
      'phone': phone,
      'address': address,
      'paymentMethod': paymentMethod,
      'totalPrice': totalPrice,
      'card': card?.toJson(),
      'orderItems': orderItems.map((item) => item.toJson()).toList()
    };
  }
}
