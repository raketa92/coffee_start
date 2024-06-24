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
}
