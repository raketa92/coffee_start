import 'package:coffee_start/features/products/data/models/product.dart';

abstract class ProductLocalService {
  Future<List<ProductModel>> getLikedProducts();
  Future<void> addLikedProduct(ProductModel product);
  Future<void> removeLikedProduct(ProductModel product);
}
