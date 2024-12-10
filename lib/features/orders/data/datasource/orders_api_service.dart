import 'package:coffee_start/core/api_response/api_response.dart';
import 'package:coffee_start/features/orders/data/datasource/dto/create_order_dto.dart';
import 'package:coffee_start/features/orders/data/models/orders.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

part 'orders_api_service.g.dart';

@retrofit.RestApi()
abstract class OrdersApiService {
  factory OrdersApiService(Dio dio) = _OrdersApiService;

  @retrofit.GET('/order')
  Future<retrofit.HttpResponse<ApiResponseList<OrderModel>>> getOrders();

  @retrofit.POST('/order')
  @retrofit.Headers({
    'Content-Type': 'application/json',
  })
  Future<retrofit.HttpResponse<ApiResponse<CreateOrderResponseDto>>>
      createOrder(@retrofit.Body() CreateOrderDto createOrderDto);
}
