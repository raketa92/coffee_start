import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final int shopId;
  final List<CartItemProductEntity> products;
  final double totalPrice;

  const CartItemEntity(
      {required this.shopId, required this.products, required this.totalPrice});

  @override
  List<Object?> get props => [shopId, products, totalPrice];

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    final products = (json['products'] as List)
        .map((product) => CartItemProductEntity.fromJson(product))
        .toList();
    return CartItemEntity(
        shopId: json['shopId'],
        products: products,
        totalPrice: _calculateTotalPrice(products));
  }

  Map<String, dynamic> toJson() {
    return {
      'shopId': shopId,
      'products': products.map((product) => product.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }

  CartItemEntity copyWith({
    int? shopId,
    List<CartItemProductEntity>? products,
    double? totalPrice,
  }) {
    return CartItemEntity(
        shopId: shopId ?? this.shopId,
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
      product: ProductEntity.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'product': product.toJson(),
    };
  }
}
