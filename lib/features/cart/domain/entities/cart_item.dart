import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String shopGuid;
  final List<CartItemProductEntity> products;
  final double totalPrice;

  const CartItemEntity(
      {required this.shopGuid,
      required this.products,
      required this.totalPrice});

  @override
  List<Object?> get props => [shopGuid, products, totalPrice];

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    final products = (json['products'] as List)
        .map((product) => CartItemProductEntity.fromJson(product))
        .toList();
    return CartItemEntity(
        shopGuid: json['shopGuid'],
        products: products,
        totalPrice: _calculateTotalPrice(products));
  }

  Map<String, dynamic> toJson() {
    return {
      'shopGuid': shopGuid,
      'products': products.map((product) => product.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }

  CartItemEntity copyWith({
    String? shopGuid,
    List<CartItemProductEntity>? products,
    double? totalPrice,
  }) {
    return CartItemEntity(
        shopGuid: shopGuid ?? this.shopGuid,
        products: products ?? this.products,
        totalPrice:
            totalPrice ?? _calculateTotalPrice(products ?? this.products));
  }

  static double _calculateTotalPrice(List<CartItemProductEntity> products) {
    return products.fold(
        0.0, (sum, item) => sum + item.product.price * item.quantity);
  }
}

class CartItemProductEntity extends Equatable {
  final int quantity;
  final ProductEntity product;

  const CartItemProductEntity({this.quantity = 1, required this.product});

  @override
  List<Object?> get props => [quantity, product];

  factory CartItemProductEntity.fromJson(Map<String, dynamic> json) {
    return CartItemProductEntity(
      quantity: json['quantity'],
      product: ProductEntity.fromJson(json['Product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'product': product.toJson(),
    };
  }
}
