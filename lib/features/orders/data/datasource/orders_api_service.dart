import 'package:coffee_start/features/orders/data/models/orders.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'orders_api_service.g.dart';

@RestApi()
abstract class OrdersApiService {
  factory OrdersApiService(Dio dio) = _OrdersApiService;

  @GET('/orders')
  Future<HttpResponse<List<OrderModel>>> getOrders();
}
