import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class ShopProductsEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final double rating;
  final List<ProductEntity> products;

  const ShopProductsEntity(
      {required this.id,
      required this.image,
      required this.name,
      required this.rating,
      required this.products});

  @override
  List<Object?> get props => [id, name, image, rating, products];

  factory ShopProductsEntity.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['products'] as List;
    List<ProductEntity> products = productsFromJson
        .map((product) => ProductEntity.fromJson(product))
        .toList();

    return ShopProductsEntity(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        rating: json['rating'],
        products: products);
  }
}
