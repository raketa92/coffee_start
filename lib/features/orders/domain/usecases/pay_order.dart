import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/orders/domain/repository/order_repository.dart';
import 'package:coffee_start/features/orders/domain/usecases/pay_order_params.dart';

class PayOrderUseCase implements UseCase<DataState<bool>, PayOrderParams> {
  final OrderRepository _orderRepository;
  PayOrderUseCase(this._orderRepository);

  @override
  Future<DataState<bool>> call({PayOrderParams? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _orderRepository.payOrder(params.cardEntity, params.orderId);
  }
}
