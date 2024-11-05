import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String guid;
  final String name;
  final String image;
  final double price;
  final String categoryGuid;
  final String shopGuid;
  final double rating;
  final List<String> ingredients;

  const ProductEntity(
      {required this.guid,
      required this.name,
      required this.image,
      required this.price,
      required this.categoryGuid,
      required this.shopGuid,
      required this.rating,
      required this.ingredients});

  @override
  List<Object?> get props =>
      [guid, name, image, price, categoryGuid, shopGuid, rating, ingredients];

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
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

  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'name': name,
      'image': image,
      'price': price,
      'categoryGuid': categoryGuid,
      'shopGuid': shopGuid,
      'rating': rating,
      'ingredients': ingredients,
    };
  }
}
