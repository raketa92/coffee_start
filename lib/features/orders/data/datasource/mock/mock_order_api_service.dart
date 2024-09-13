import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/orders/data/datasource/orders_api_service.dart';
import 'package:coffee_start/features/orders/data/models/orders.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

class MockOrdersApiService implements OrdersApiService {
  @override
  Future<HttpResponse<String>> createOrder(CheckoutData checkoutData) async {
    final String orderId = DateTime.now().microsecondsSinceEpoch.toString();
    return HttpResponse(
        orderId,
        Response(
            data: orderId,
            statusCode: 201,
            requestOptions: RequestOptions(path: '/order')));
  }

  @override
  Future<HttpResponse<List<OrderModel>>> getOrders() {
    // TODO: implement getOrders
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<bool>> payOrder(CardEntity cardEntity, String orderId) {
    // TODO: implement payOrder
    throw UnimplementedError();
  }
}
