import 'package:coffee_start/core/api_response/api_response.dart';
import 'package:coffee_start/features/products/data/models/product.dart';
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

  @GET('/product')
  Future<HttpResponse<ApiResponseList<ProductModel>>> getProductsByShop(
      @Query("shopGuid") String shopGuid);

  @GET('/product')
  Future<HttpResponse<ApiResponseList<ProductModel>>> getProductsByCategory(
      @Query("categoryGuid") String categoryGuid);

  @GET('/product/{productGuid}')
  Future<HttpResponse<ApiResponse<ProductModel>>> getProduct(
      @Path("productGuid") String productGuid);
}
