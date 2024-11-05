import 'package:coffee_start/core/api_response/api_response.dart';
import 'package:coffee_start/features/products/data/models/product.dart';
import 'package:coffee_start/features/products/data/models/products_by_category.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'products_api_service.g.dart';

@RestApi()
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio) = _ProductsApiService;

  @GET('/product')
  Future<HttpResponse<ApiResponseList<ProductModel>>> getProducts();

  @GET('/product?isNew=true')
  Future<HttpResponse<ApiResponseList<ProductModel>>> getNewProducts();

  @GET('/product?isPopular=true')
  Future<HttpResponse<ApiResponseList<ProductModel>>> getPopularProducts();

  @GET('/product?categoryGuid={categoryId}')
  Future<HttpResponse<ProductsByCategoryModel>> getProductsByCategory(
      @Path("categoryId") int categoryId);

  @GET('/product/{productGuid}')
  Future<HttpResponse<ApiResponse<ProductModel>>> getProduct(
      @Path("productGuid") String productGuid);
}
