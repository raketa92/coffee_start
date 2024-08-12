import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';

class OrderModel extends OrderEntity {
  const OrderModel(
      {required super.id,
      required super.shopName,
      required super.rating,
      required super.totalPrice,
      required super.products});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['products'] as List;
    List<ProductEntity> products = productsFromJson
        .map((product) => ProductEntity.fromJson(product))
        .toList();

    return OrderModel(
        id: int.parse(json['id']),
        totalPrice: json['image'],
        shopName: json['name'],
        rating: json['rating'],
        products: products);
  }
}
