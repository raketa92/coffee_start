import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository.dart';

class GetProductsByShopUseCase
    implements UseCase<DataState<List<ProductEntity>>, String> {
  final ProductRepository _productRepository;
  GetProductsByShopUseCase(this._productRepository);

  @override
  Future<DataState<List<ProductEntity>>> call({String? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _productRepository.getProductsByShop(params);
  }
}
