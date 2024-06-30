import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/shops/domain/entities/shop.dart';
import 'package:coffee_start/features/shops/domain/repository/shop_repository.dart';

class GetShopsUseCase implements UseCase<DataState<List<ShopEntity>>, void> {
  final ShopRepository _shopRepository;
  GetShopsUseCase(this._shopRepository);

  @override
  Future<DataState<List<ShopEntity>>> call({void params}) {
    return _shopRepository.getShops();
  }
}
