import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel(
      {required super.shopGuid,
      required super.products,
      required super.totalPrice});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        shopGuid: json['shopGuid'],
        products: (json['products'] as List)
            .map((item) => CartItemProductEntity.fromJson(item))
            .toList(),
        totalPrice: json['totalPrice']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'shopId': shopGuid,
      'products': products.map((product) => product.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }

  static CartItemModel fromEntity(CartItemEntity entity) {
    return CartItemModel(
        shopGuid: entity.shopGuid,
        products: entity.products,
        totalPrice: entity.totalPrice);
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
        shopGuid: shopGuid, products: products, totalPrice: totalPrice);
  }
}
