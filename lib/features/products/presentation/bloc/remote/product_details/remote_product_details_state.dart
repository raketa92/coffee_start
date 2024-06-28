part of 'remote_product_details_bloc.dart';

sealed class RemoteProductDetailsState extends Equatable {
  const RemoteProductDetailsState();

  @override
  List<Object> get props => [];
}

final class RemoteProductDetailsInitial extends RemoteProductDetailsState {}

final class RemoteProductDetailsLoading extends RemoteProductDetailsState {}

final class RemoteProductDetailsLoaded extends RemoteProductDetailsState {
  final ProductEntity product;
  const RemoteProductDetailsLoaded(this.product);

  @override
  List<Object> get props => [product];
}

final class RemoteProductDetailsError extends RemoteProductDetailsState {
  final DioException error;
  const RemoteProductDetailsError(this.error);

  @override
  List<Object> get props => [error];
}
