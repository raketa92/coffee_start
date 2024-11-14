import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/orders/domain/repository/order_repository.dart';

class ConfirmSmsOrderUseCase
    implements UseCase<DataState<String>, ConfirmOrderRequestDto> {
  final OrderRepository _orderRepository;
  ConfirmSmsOrderUseCase(this._orderRepository);

  @override
  Future<DataState<String>> call({ConfirmOrderRequestDto? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _orderRepository.confirmSmsOrder(params);
  }
}

class ConfirmOrderRequestDto {
  String orderNumber;
  String sms;
  ConfirmOrderRequestDto(this.orderNumber, this.sms);
}
