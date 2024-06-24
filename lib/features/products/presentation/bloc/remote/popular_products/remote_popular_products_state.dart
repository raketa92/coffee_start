part of 'remote_popular_products_bloc.dart';

sealed class RemotePopularProductsState extends Equatable {
  const RemotePopularProductsState();

  @override
  List<Object> get props => [];
}

final class RemotePopularProductsInitial extends RemotePopularProductsState {}

final class RemotePopularProductsLoading extends RemotePopularProductsState {}

final class RemotePopularProductsLoaded extends RemotePopularProductsState {
  final List<ProductEntity> products;
  const RemotePopularProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class RemotePopularProductsError extends RemotePopularProductsState {
  final DioException error;
  const RemotePopularProductsError(this.error);

  @override
  List<Object> get props => [error];
}
