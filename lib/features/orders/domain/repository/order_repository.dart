import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/orders/data/datasource/dto/createOrderDto.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/domain/usecases/confirm_sms_order.dart';

abstract class OrderRepository {
  Future<DataState<List<OrderEntity>>> getOrders();
  Future<DataState<String>> createOrder(CreateOrderDto createOrderDto);
  Future<DataState<String>> confirmSmsOrder(ConfirmOrderRequestDto data);
}
