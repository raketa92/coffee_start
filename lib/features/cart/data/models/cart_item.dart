import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel(
      {required super.shopId,
      required super.products,
      required super.totalPrice});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        shopId: json['shopId'],
        products: (json['products'] as List)
            .map((item) => CartItemProductEntity.fromJson(item))
            .toList(),
        totalPrice: json['totalPrice']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'shopId': shopId,
      'products': products.map((product) => product.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }

  static CartItemModel fromEntity(CartItemEntity entity) {
    return CartItemModel(
        shopId: entity.shopId,
        products: entity.products,
        totalPrice: entity.totalPrice);
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
        shopId: shopId, products: products, totalPrice: totalPrice);
  }
}
