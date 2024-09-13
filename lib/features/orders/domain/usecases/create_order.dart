import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/features/orders/domain/repository/order_repository.dart';

class CreateOrdersUseCase implements UseCase<DataState<String>, CheckoutData> {
  final OrderRepository _orderRepository;
  CreateOrdersUseCase(this._orderRepository);

  @override
  Future<DataState<String>> call({CheckoutData? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _orderRepository.createOrder(params);
  }
}
