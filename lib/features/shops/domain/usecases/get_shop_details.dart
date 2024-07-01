import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/shops/domain/entities/shop_products.dart';
import 'package:coffee_start/features/shops/domain/repository/shop_repository.dart';

class GetShopDetailsUseCase
    implements UseCase<DataState<ShopProductsEntity>, int> {
  final ShopRepository _shopRepository;
  GetShopDetailsUseCase(this._shopRepository);

  @override
  Future<DataState<ShopProductsEntity>> call({int? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _shopRepository.getShop(params);
  }
}
