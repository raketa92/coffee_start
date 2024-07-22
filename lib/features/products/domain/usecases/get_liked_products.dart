import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository_local.dart';

class GetLikedProductsUseCase implements UseCase<List<ProductEntity>, void> {
  final ProductRepositoryLocal _productRepositoryLocal;
  GetLikedProductsUseCase(this._productRepositoryLocal);

  @override
  Future<List<ProductEntity>> call({void params}) {
    return _productRepositoryLocal.getLikedProducts();
  }
}
