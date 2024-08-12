import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/cart/domain/repository/cart_repository_local.dart';
import 'package:coffee_start/features/cart/domain/usecases/cart_params.dart';

class RemoveFromCartUseCase implements UseCase<void, CartParams> {
  final CartItemRepositoryLocal _cartItemRepositoryLocal;
  RemoveFromCartUseCase(this._cartItemRepositoryLocal);

  @override
  Future<void> call({CartParams? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _cartItemRepositoryLocal.removeFromCart(params);
  }
}
