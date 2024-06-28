import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository.dart';

class GetProductsByCategoryUseCase
    implements UseCase<DataState<List<ProductEntity>>, int> {
  final ProductRepository _productRepository;
  GetProductsByCategoryUseCase(this._productRepository);

  @override
  Future<DataState<List<ProductEntity>>> call({int? params}) {
    print("params:");
    print(params);
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _productRepository.getProductsByCategory(params);
  }
}
