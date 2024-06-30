import 'package:coffee_start/features/shops/domain/entities/shop.dart';

class ShopModel extends ShopEntity {
  const ShopModel(
      {required super.id,
      required super.image,
      required super.name,
      required super.rating});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        rating: json['rating']);
  }
}
