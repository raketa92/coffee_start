import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';

abstract class OrderRepository {
  Future<DataState<List<OrderEntity>>> getOrders();
  Future<DataState<String>> createOrder(CheckoutData checkoutData);
}
