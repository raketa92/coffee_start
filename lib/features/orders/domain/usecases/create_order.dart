import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/orders/data/datasource/dto/create_order_dto.dart';
import 'package:coffee_start/features/orders/domain/repository/order_repository.dart';

class CreateOrdersUseCase
    implements UseCase<DataState<CreateOrderResponseDto>, CreateOrderDto> {
  final OrderRepository _orderRepository;
  CreateOrdersUseCase(this._orderRepository);

  @override
  Future<DataState<CreateOrderResponseDto>> call({CreateOrderDto? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _orderRepository.createOrder(params);
  }
}
