import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final double price;
  final int categoryId;
  final int shopId;
  final double rating;
  final List<String> ingredients;

  const ProductEntity(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.categoryId,
      required this.shopId,
      required this.rating,
      required this.ingredients});

  @override
  List<Object?> get props =>
      [id, name, image, price, categoryId, shopId, rating, ingredients];

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'categoryId': categoryId,
      'shopId': shopId,
      'rating': rating,
      'ingredients': ingredients,
    };
  }
}
