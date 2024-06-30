import 'package:coffee_start/features/shops/data/models/shop.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'shops_api_service.g.dart';

@RestApi()
abstract class ShopsApiService {
  factory ShopsApiService(Dio dio) = _ShopsApiService;

  @GET('/shops')
  Future<HttpResponse<List<ShopModel>>> getShops();

  @GET('/shops/{shopId}')
  Future<HttpResponse<ShopModel>> getShop(@Path("shopId") int shopId);
}
