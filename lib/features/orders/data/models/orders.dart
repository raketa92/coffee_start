import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';

class OrderModel extends OrderEntity {
  const OrderModel(
      {required super.id,
      required super.shopName,
      required super.rating,
      required super.totalPrice,
      required super.products});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['products'] as List;
    List<CartItemProductEntity> products = productsFromJson
        .map((product) => CartItemProductEntity.fromJson(product))
        .toList();

    return OrderModel(
        id: (json['id']),
        totalPrice: json['image'],
        shopName: json['name'],
        rating: json['rating'],
        products: products);
  }
}
