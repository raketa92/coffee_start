import 'package:equatable/equatable.dart';

class ShopEntity extends Equatable {
  final String guid;
  final String name;
  final String image;
  final double rating;

  const ShopEntity(
      {required this.guid,
      required this.image,
      required this.name,
      required this.rating});

  @override
  List<Object?> get props => [guid, name, image, rating];

  factory ShopEntity.fromJson(Map<String, dynamic> json) {
    return ShopEntity(
        guid: json['guid'],
        image: json['image'],
        name: json['name'],
        rating: json['rating']);
  }
}
