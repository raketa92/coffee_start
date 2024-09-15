import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String shopName;
  final double rating;
  final double totalPrice;
  final List<CartItemProductEntity> products;

  const OrderEntity(
      {required this.id,
      required this.shopName,
      required this.totalPrice,
      required this.rating,
      required this.products});

  @override
  List<Object?> get props => [id, shopName, totalPrice, rating];

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['products'] as List;
    List<CartItemProductEntity> products = productsFromJson
        .map((product) => CartItemProductEntity.fromJson(product))
        .toList();
    return OrderEntity(
        id: json['id'],
        totalPrice: json['totalPrice'],
        shopName: json['name'],
        rating: json['rating'],
        products: products);
  }
}
