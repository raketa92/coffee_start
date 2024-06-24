import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository.dart';

class GetProductsUseCase
    implements UseCase<DataState<List<ProductEntity>>, void> {
  final ProductRepository _productRepository;
  GetProductsUseCase(this._productRepository);

  @override
  Future<DataState<List<ProductEntity>>> call({void params}) {
    return _productRepository.getProducts();
  }
}
