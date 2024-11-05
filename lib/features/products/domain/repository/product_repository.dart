import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<DataState<List<ProductEntity>>> getProducts();
  Future<DataState<List<ProductEntity>>> getNewProducts();
  Future<DataState<List<ProductEntity>>> getPopularProducts();
  Future<DataState<List<ProductEntity>>> getProductsByCategory(int categoryId);
  Future<DataState<ProductEntity>> getProduct(String productGuid);
}
