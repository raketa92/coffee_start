import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final double price;
  final int categoryId;
  final double rating;
  final List<String>? ingredients;

  const ProductEntity(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.categoryId,
      required this.rating,
      this.ingredients});

  @override
  List<Object?> get props =>
      [id, name, image, price, categoryId, rating, ingredients];

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
        id: json['id'],
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
