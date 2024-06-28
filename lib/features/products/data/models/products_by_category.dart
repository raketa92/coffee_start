import 'package:coffee_start/features/products/domain/entities/product.dart';

class ProductsByCategoryModel {
  final int id;
  final List<ProductEntity> products;
  const ProductsByCategoryModel({required this.id, required this.products});

  factory ProductsByCategoryModel.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['products'] as List;
    List<ProductEntity> products = productsFromJson
        .map((product) => ProductEntity.fromJson(product))
        .toList();

    return ProductsByCategoryModel(
        id: int.parse(json['id']), products: products);
  }
}
