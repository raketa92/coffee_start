import 'package:coffee_start/features/products/data/models/product.dart';
import 'package:coffee_start/features/products/data/models/products_by_category.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'products_api_service.g.dart';

@RestApi()
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio) = _ProductsApiService;

  @GET('/products')
  Future<HttpResponse<List<ProductModel>>> getProducts();

  @GET('/products-new')
  Future<HttpResponse<List<ProductModel>>> getNewProducts();

  @GET('/products-popular')
  Future<HttpResponse<List<ProductModel>>> getPopularProducts();

  @GET('/products-by-category/{categoryId}')
  Future<HttpResponse<ProductsByCategoryModel>> getProductsByCategory(
      @Path("categoryId") int categoryId);

  @GET('/products/{productId}')
  Future<HttpResponse<ProductModel>> getProduct(
      @Path("productId") int productId);
}
