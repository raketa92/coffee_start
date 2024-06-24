import 'package:coffee_start/features/products/domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.name,
      required super.image,
      required super.price,
      required super.categoryId,
      required super.rating,
      required super.ingredients});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: int.parse(json['id']),
        name: json['name'],
        image: json['image'],
        price: json['price'].toDouble(),
        categoryId: json['categoryId'].toInt(),
        rating: json['rating'].toDouble(),
        ingredients: json['ingredients'] != null
            ? List<String>.from(json['ingredients'])
            : []);
  }
}
