import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/domain/repository/order_repository.dart';

class GetOrdersUseCase implements UseCase<DataState<List<OrderEntity>>, void> {
  final OrderRepository _orderRepository;
  GetOrdersUseCase(this._orderRepository);

  @override
  Future<DataState<List<OrderEntity>>> call({void params}) {
    return _orderRepository.getOrders();
  }
}
