import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/cart/domain/repository/cart_repository_local.dart';

class SaveCartItemsUseCase implements UseCase<void, List<CartItemEntity>> {
  final CartItemRepositoryLocal _cartItemRepositoryLocal;
  SaveCartItemsUseCase(this._cartItemRepositoryLocal);

  @override
  Future<void> call({List<CartItemEntity>? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _cartItemRepositoryLocal.saveCartItemProducts(params);
  }
}
