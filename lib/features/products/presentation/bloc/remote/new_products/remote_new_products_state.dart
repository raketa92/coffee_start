part of 'remote_new_products_bloc.dart';

sealed class RemoteNewProductsState extends Equatable {
  const RemoteNewProductsState();

  @override
  List<Object> get props => [];
}

final class RemoteNewProductsInitial extends RemoteNewProductsState {}

final class RemoteNewProductsLoading extends RemoteNewProductsState {}

final class RemoteNewProductsLoaded extends RemoteNewProductsState {
  final List<ProductEntity> products;
  const RemoteNewProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class RemoteNewProductsError extends RemoteNewProductsState {
  final DioException error;
  const RemoteNewProductsError(this.error);

  @override
  List<Object> get props => [error];
}
