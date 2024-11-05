part of 'remote_products_by_shop_bloc.dart';

sealed class RemoteProductsByShopState extends Equatable {
  const RemoteProductsByShopState();

  @override
  List<Object> get props => [];
}

final class RemoteProductsByShopInitial extends RemoteProductsByShopState {}

final class RemoteProductsByShopLoading extends RemoteProductsByShopState {}

final class RemoteProductsByShopLoaded extends RemoteProductsByShopState {
  final List<ProductEntity> products;
  const RemoteProductsByShopLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class RemoteProductsByShopError extends RemoteProductsByShopState {
  final DioException error;
  const RemoteProductsByShopError(this.error);

  @override
  List<Object> get props => [error];
}
