import 'package:coffee_start/features/categories/domain/entities/category.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel(
      {required super.id, required super.name, required super.iconUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'] is int ? json['id'] : int.parse(json['id']),
        name: json['name'],
        iconUrl: json['iconUrl']);
  }
}
