import 'dart:convert';

import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/products/data/models/product.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository_local.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ProductRepositoryLocalImpl implements ProductRepositoryLocal {
  final HydratedStorage storage;

  ProductRepositoryLocalImpl({required this.storage});
  @override
  Future<void> addLikedProduct(ProductEntity product) async {
    final likedProducts = await getLikedProducts();
    likedProducts.add(ProductModel.fromEntity(product));
    await _saveLikedProducts(likedProducts);
  }

  @override
  Future<List<ProductEntity>> getLikedProducts() async {
    final jsonString = storage.read(likedProductsLocalStorageKey);
    if (jsonString != null) {
      final List<dynamic> decodedJson = json.decode(jsonString);
      return decodedJson
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
    }
    return [];
  }

  @override
  Future<void> removeLikedProduct(ProductEntity product) async {
    final likedProducts = await getLikedProducts();
    likedProducts.removeWhere((element) => element.guid == product.guid);
    await _saveLikedProducts(likedProducts);
  }

  Future<void> _saveLikedProducts(List<ProductEntity> likedProducts) async {
    final List<Map<String, dynamic>> likedProductsJson = likedProducts
        .map((product) => ProductModel.fromEntity(product).toJson())
        .toList();
    final jsonString = json.encode(likedProductsJson);
    await storage.write(likedProductsLocalStorageKey, jsonString);
  }
}
