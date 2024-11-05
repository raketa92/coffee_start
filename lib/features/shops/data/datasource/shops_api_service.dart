import 'package:coffee_start/core/api_response/api_response.dart';
import 'package:coffee_start/features/shops/data/models/shop.dart';
import 'package:coffee_start/features/shops/data/models/shop_products.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'shops_api_service.g.dart';

@RestApi()
abstract class ShopsApiService {
  factory ShopsApiService(Dio dio) = _ShopsApiService;

  @GET('/shop')
  Future<HttpResponse<ApiResponseList<ShopModel>>> getShops();

  @GET('/shop/{shopGuid}')
  Future<HttpResponse<ApiResponse<ShopProductsModel>>> getShop(
      @Path("shopGuid") String shopGuid);
}
