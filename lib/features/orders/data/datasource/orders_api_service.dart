import 'package:coffee_start/features/orders/data/models/orders.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

part 'orders_api_service.g.dart';

@retrofit.RestApi()
abstract class OrdersApiService {
  factory OrdersApiService(Dio dio) = _OrdersApiService;

  @retrofit.GET('/order')
  Future<retrofit.HttpResponse<List<OrderModel>>> getOrders();

  @retrofit.POST('/order')
  @retrofit.Headers({
    'Content-Type': 'application/json',
  })
  Future<retrofit.HttpResponse<String>> createOrder(
      @retrofit.Body() CheckoutData checkoutData);
}
