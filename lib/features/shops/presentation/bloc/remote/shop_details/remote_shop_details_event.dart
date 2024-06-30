part of 'remote_shop_details_bloc.dart';

sealed class RemoteShopDetailsEvent extends Equatable {
  const RemoteShopDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetShopDetails extends RemoteShopDetailsEvent {
  final int shopId;
  const GetShopDetails(this.shopId);
}