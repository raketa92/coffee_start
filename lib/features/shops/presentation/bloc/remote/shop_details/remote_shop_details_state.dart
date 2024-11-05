part of 'remote_shop_details_bloc.dart';

sealed class RemoteShopDetailsState extends Equatable {
  const RemoteShopDetailsState();

  @override
  List<Object> get props => [];
}

final class RemoteShopDetailsInitial extends RemoteShopDetailsState {}

final class RemoteShopDetailsLoading extends RemoteShopDetailsState {}

final class RemoteShopDetailsLoaded extends RemoteShopDetailsState {
  final ShopEntity shop;
  const RemoteShopDetailsLoaded(this.shop);

  @override
  List<Object> get props => [shop];
}

final class RemoteShopDetailsError extends RemoteShopDetailsState {
  final DioException error;
  const RemoteShopDetailsError(this.error);

  @override
  List<Object> get props => [error];
}
