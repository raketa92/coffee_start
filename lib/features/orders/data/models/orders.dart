import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';

class OrderModel extends OrderEntity {
  const OrderModel(
      {required super.guid,
      super.orderNumber,
      required super.shopName,
      required super.rating,
      required super.totalPrice,
      required super.products,
      required super.status,
      required super.date});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['OrderItems'] as List;
    List<CartItemProductEntity> products = productsFromJson
        .map((product) => CartItemProductEntity.fromJson(product))
        .toList();

    return OrderModel(
        guid: json['guid'] ?? '',
        orderNumber: json['orderNumber'],
        totalPrice: json['totalPrice'] is String
            ? double.parse(json['totalPrice'])
            : json['totalPrice'].toDouble(),
        shopName: json['shopName'],
        rating: json['shopRating'],
        products: products,
        status: OrderStatuses.values
            .firstWhere((e) => e.toString().split('.').last == json['status']),
        date: DateTime.parse(json['date']));
  }
}
