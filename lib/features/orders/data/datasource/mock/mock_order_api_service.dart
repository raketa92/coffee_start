import 'package:coffee_start/core/api_response/api_response.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/orders/data/datasource/dto/createOrderDto.dart';
import 'package:coffee_start/features/orders/data/datasource/orders_api_service.dart';
import 'package:coffee_start/features/orders/data/models/orders.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

class MockOrdersApiService implements OrdersApiService {
  @override
  Future<HttpResponse<String>> createOrder(
      CreateOrderDto createOrderDto) async {
    final String orderId = DateTime.now().microsecondsSinceEpoch.toString();
    return HttpResponse(
        orderId,
        Response(
            data: orderId,
            statusCode: 201,
            requestOptions: RequestOptions(path: '/order')));
  }

  @override
  Future<HttpResponse<ApiResponseList<OrderModel>>> getOrders() async {
    final String orderId = DateTime.now().microsecondsSinceEpoch.toString();
    final String orderId2 = DateTime.now().microsecondsSinceEpoch.toString();
    final List<OrderModel> orders = [
      OrderModel(
          guid: orderId,
          shopName: 'Shop 1',
          rating: 4.5,
          totalPrice: 22,
          products: const [
            CartItemProductEntity(
              quantity: 2,
              product: ProductEntity(
                  guid: "1",
                  name: 'Cappucino',
                  image: 'cappucino.jpg',
                  price: 25,
                  categoryGuid: "1",
                  shopGuid: "1",
                  rating: 4,
                  ingredients: ['caramel syrup', 'fruit syrup']),
            ),
            CartItemProductEntity(
              quantity: 1,
              product: ProductEntity(
                  guid: "2",
                  name: 'Glace',
                  image: 'glace.jpg',
                  price: 30,
                  categoryGuid: "2",
                  shopGuid: "1",
                  rating: 4,
                  ingredients: ['shocolate']),
            )
          ],
          status: OrderStatuses.pending,
          date: DateTime.now()),
      OrderModel(
          guid: orderId2,
          shopName: 'Shop 2',
          rating: 4.5,
          totalPrice: 22,
          products: const [
            CartItemProductEntity(
              quantity: 2,
              product: ProductEntity(
                  guid: "1",
                  name: 'Cappucino',
                  image: 'cappucino.jpg',
                  price: 25,
                  categoryGuid: "1",
                  shopGuid: "1",
                  rating: 4,
                  ingredients: ['caramel syrup', 'fruit syrup']),
            ),
            CartItemProductEntity(
              quantity: 1,
              product: ProductEntity(
                  guid: "2",
                  name: 'Glace',
                  image: 'glace.jpg',
                  price: 30,
                  categoryGuid: "2",
                  shopGuid: "1",
                  rating: 4,
                  ingredients: ['shocolate']),
            )
          ],
          status: OrderStatuses.completed,
          date: DateTime.now()),
    ];

    final response = HttpResponse(
        orders,
        Response(
            data: orders,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/order')));
    return response.response.data;
  }

  @override
  Future<HttpResponse<String>> confirmSmsOrder(String orderNumber, String sms) {
    // TODO: implement confirmSmsOrder
    throw UnimplementedError();
  }
}
