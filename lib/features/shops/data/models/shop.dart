import 'package:coffee_start/features/shops/domain/entities/shop.dart';

class ShopModel extends ShopEntity {
  const ShopModel(
      {required super.guid,
      required super.image,
      required super.name,
      required super.rating});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
        guid: json['guid'],
        image: json['image'],
        name: json['name'],
        rating: json['rating']);
  }
}
