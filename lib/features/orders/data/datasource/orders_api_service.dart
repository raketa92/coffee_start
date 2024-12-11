import 'package:coffee_start/core/api_response/api_response.dart';
import 'package:coffee_start/features/orders/data/datasource/dto/create_order_dto.dart';
import 'package:coffee_start/features/orders/data/models/orders.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'orders_api_service.g.dart';

@RestApi()
abstract class OrdersApiService {
  factory OrdersApiService(Dio dio) = _OrdersApiService;

  @GET('/order')
  Future<HttpResponse<ApiResponseList<OrderModel>>> getOrders();

  @GET('/order')
  Future<HttpResponse<ApiResponseList<OrderModel>>> getOrder(
      @Query("orderNumbers") String categoryGuid);

  @POST('/order')
  @Headers({
    'Content-Type': 'application/json',
  })
  Future<HttpResponse<ApiResponse<CreateOrderResponseDto>>> createOrder(
      @Body() CreateOrderDto createOrderDto);
}
