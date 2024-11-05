import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/shops/domain/entities/shop.dart';
import 'package:coffee_start/features/shops/domain/repository/shop_repository.dart';

class GetShopDetailsUseCase implements UseCase<DataState<ShopEntity>, String> {
  final ShopRepository _shopRepository;
  GetShopDetailsUseCase(this._shopRepository);

  @override
  Future<DataState<ShopEntity>> call({String? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _shopRepository.getShop(params);
  }
}
