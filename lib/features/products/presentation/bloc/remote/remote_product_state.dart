part of 'remote_product_bloc.dart';

sealed class RemoteProductState extends Equatable {
  const RemoteProductState();

  @override
  List<Object> get props => [];
}

final class RemoteProductInitial extends RemoteProductState {}

final class RemoteProductLoading extends RemoteProductState {}

final class RemoteProductLoaded extends RemoteProductState {
  final List<ProductEntity> products;
  const RemoteProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class RemoteProductError extends RemoteProductState {
  final DioException error;
  const RemoteProductError(this.error);

  @override
  List<Object> get props => [error];
}
