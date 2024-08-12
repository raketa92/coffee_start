import 'package:coffee_start/features/products/domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.name,
      required super.image,
      required super.price,
      required super.categoryId,
      required super.shopId,
      required super.rating,
      required super.ingredients});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'] is int ? json['id'] : int.parse(json['id']),
        name: json['name'],
        image: json['image'],
        price: json['price'] is String
            ? double.parse(json['price'])
            : json['price'].toDouble(),
        categoryId: json['categoryId'] is int
            ? json['categoryId']
            : int.parse(json['categoryId']),
        shopId:
            json['shopId'] is int ? json['shopId'] : int.parse(json['shopId']),
        rating: json['rating'] is String
            ? double.parse(json['rating'])
            : json['rating'].toDouble(),
        ingredients: json['ingredients'] != null
            ? List<String>.from(json['ingredients'])
            : []);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price.toString(),
      'categoryId': categoryId,
      'shopId': shopId,
      'rating': rating.toString(),
      'ingredients': ingredients
    };
  }

  static ProductModel fromEntity(ProductEntity entity) {
    return ProductModel(
        id: entity.id,
        name: entity.name,
        image: entity.image,
        price: entity.price,
        categoryId: entity.categoryId,
        shopId: entity.shopId,
        rating: entity.rating,
        ingredients: entity.ingredients);
  }
}
