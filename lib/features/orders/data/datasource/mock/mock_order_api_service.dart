import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/orders/data/datasource/orders_api_service.dart';
import 'package:coffee_start/features/orders/data/models/orders.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
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
  Future<HttpResponse<List<OrderModel>>> getOrders() async {
    final String orderId = DateTime.now().microsecondsSinceEpoch.toString();
    final String orderId2 = DateTime.now().microsecondsSinceEpoch.toString();
    final List<OrderModel> orders = [
      OrderModel(
          id: orderId,
          shopName: 'Shop 1',
          rating: 4.5,
          totalPrice: 22,
          products: const [
            CartItemProductEntity(
              quantity: 2,
              product: ProductEntity(
                  id: 1,
                  name: 'Cappucino',
                  image: 'cappucino.jpg',
                  price: 25,
                  categoryId: 1,
                  shopId: 1,
                  rating: 4,
                  ingredients: ['caramel syrup', 'fruit syrup']),
            ),
            CartItemProductEntity(
              quantity: 1,
              product: ProductEntity(
                  id: 2,
                  name: 'Glace',
                  image: 'glace.jpg',
                  price: 30,
                  categoryId: 2,
                  shopId: 1,
                  rating: 4,
                  ingredients: ['shocolate']),
            )
          ]),
      OrderModel(
          id: orderId,
          shopName: 'Shop 2',
          rating: 4.5,
          totalPrice: 22,
          products: const [
            CartItemProductEntity(
              quantity: 2,
              product: ProductEntity(
                  id: 1,
                  name: 'Cappucino',
                  image: 'cappucino.jpg',
                  price: 25,
                  categoryId: 1,
                  shopId: 1,
                  rating: 4,
                  ingredients: ['caramel syrup', 'fruit syrup']),
            ),
            CartItemProductEntity(
              quantity: 1,
              product: ProductEntity(
                  id: 2,
                  name: 'Glace',
                  image: 'glace.jpg',
                  price: 30,
                  categoryId: 2,
                  shopId: 1,
                  rating: 4,
                  ingredients: ['shocolate']),
            )
          ]),
    ];

    return HttpResponse(
        orders,
        Response(
            data: orders,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/order')));
  }
}
