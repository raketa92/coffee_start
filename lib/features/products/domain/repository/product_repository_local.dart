import 'package:coffee_start/features/products/domain/entities/product.dart';

abstract class ProductRepositoryLocal {
  Future<List<ProductEntity>> getLikedProducts();
  Future<void> addLikedProduct(ProductEntity product);
  Future<void> removeLikedProduct(ProductEntity product);
}
