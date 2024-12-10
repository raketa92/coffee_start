import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/orders/data/datasource/dto/create_order_dto.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';

abstract class OrderRepository {
  Future<DataState<List<OrderEntity>>> getOrders();
  Future<DataState<CreateOrderResponseDto>> createOrder(
      CreateOrderDto createOrderDto);
}
