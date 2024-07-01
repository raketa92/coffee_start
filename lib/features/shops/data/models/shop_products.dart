import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/shops/domain/entities/shop_products.dart';

class ShopProductsModel extends ShopProductsEntity {
  const ShopProductsModel(
      {required super.id,
      required super.image,
      required super.name,
      required super.rating,
      required super.products});

  factory ShopProductsModel.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['products'] as List;
    List<ProductEntity> products = productsFromJson
        .map((product) => ProductEntity.fromJson(product))
        .toList();

    return ShopProductsModel(
        id: int.parse(json['id']),
        image: json['image'],
        name: json['name'],
        rating: json['rating'],
        products: products);
  }
}
