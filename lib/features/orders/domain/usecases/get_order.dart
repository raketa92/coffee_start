import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/domain/repository/order_repository.dart';

class GetOrderUseCase implements UseCase<DataState<OrderEntity>, String> {
  final OrderRepository _orderRepository;
  GetOrderUseCase(this._orderRepository);

  @override
  Future<DataState<OrderEntity>> call({String? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _orderRepository.getOrder(params);
  }
}
