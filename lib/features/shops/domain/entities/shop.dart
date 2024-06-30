import 'package:equatable/equatable.dart';

class ShopEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final double rating;

  const ShopEntity(
      {required this.id,
      required this.image,
      required this.name,
      required this.rating});

  @override
  List<Object?> get props => [id, name, image, rating];

  factory ShopEntity.fromJson(Map<String, dynamic> json) {
    return ShopEntity(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        rating: json['rating']);
  }
}
