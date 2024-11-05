import 'package:coffee_start/features/categories/domain/entities/category.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel(
      {required super.guid, required super.name, required super.iconUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        guid: json['guid'], name: json['name'], iconUrl: json['iconUrl']);
  }
}
