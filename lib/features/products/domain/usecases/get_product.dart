import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository.dart';

class GetProductUseCase implements UseCase<DataState<ProductEntity>, int> {
  final ProductRepository _productRepository;
  GetProductUseCase(this._productRepository);

  @override
  Future<DataState<ProductEntity>> call({int? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _productRepository.getProduct(params);
  }
}
