import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/cart/domain/repository/cart_repository_local.dart';

class GetCartItemsUseCase implements UseCase<List<CartItemEntity>, void> {
  final CartItemRepositoryLocal _cartItemRepositoryLocal;
  GetCartItemsUseCase(this._cartItemRepositoryLocal);

  @override
  Future<List<CartItemEntity>> call({void params}) {
    return _cartItemRepositoryLocal.getCartItems();
  }
}
