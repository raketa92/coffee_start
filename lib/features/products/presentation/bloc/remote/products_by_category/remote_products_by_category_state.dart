part of 'remote_products_by_category_bloc.dart';

sealed class RemoteProductsByCategoryState extends Equatable {
  const RemoteProductsByCategoryState();

  @override
  List<Object> get props => [];
}

final class RemoteProductsByCategoryInitial
    extends RemoteProductsByCategoryState {}

final class RemoteProductsByCategoryLoading
    extends RemoteProductsByCategoryState {}

final class RemoteProductsByCategoryLoaded
    extends RemoteProductsByCategoryState {
  final List<ProductEntity> products;
  const RemoteProductsByCategoryLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class RemoteProductsByCategoryError
    extends RemoteProductsByCategoryState {
  final DioException error;
  const RemoteProductsByCategoryError(this.error);

  @override
  List<Object> get props => [error];
}
