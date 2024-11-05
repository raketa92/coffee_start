import 'package:coffee_start/features/products/domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.guid,
      required super.name,
      required super.image,
      required super.price,
      required super.categoryGuid,
      required super.shopGuid,
      required super.rating,
      required super.ingredients});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        guid: json['guid'],
        name: json['name'],
        image: json['image'],
        price: json['price'] is String
            ? double.parse(json['price'])
            : json['price'].toDouble(),
        categoryGuid: json['categoryGuid'],
        shopGuid: json['shopGuid'],
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
      'id': guid,
      'name': name,
      'image': image,
      'price': price.toString(),
      'categoryId': categoryGuid,
      'shopId': shopGuid,
      'rating': rating.toString(),
      'ingredients': ingredients
    };
  }

  static ProductModel fromEntity(ProductEntity entity) {
    return ProductModel(
        guid: entity.guid,
        name: entity.name,
        image: entity.image,
        price: entity.price,
        categoryGuid: entity.categoryGuid,
        shopGuid: entity.shopGuid,
        rating: entity.rating,
        ingredients: entity.ingredients);
  }
}
