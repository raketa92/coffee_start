import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository_local.dart';

class RemoveLikedProductUseCase implements UseCase<void, ProductEntity> {
  final ProductRepositoryLocal _productRepositoryLocal;
  RemoveLikedProductUseCase(this._productRepositoryLocal);

  @override
  Future<void> call({ProductEntity? params}) {
    if (params == null) {
      throw ArgumentError('params cannot be null');
    }
    return _productRepositoryLocal.removeLikedProduct(params);
  }
}
