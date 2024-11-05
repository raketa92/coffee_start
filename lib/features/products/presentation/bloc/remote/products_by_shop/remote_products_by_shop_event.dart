part of 'remote_products_by_shop_bloc.dart';

sealed class RemoteProductsByShopEvent extends Equatable {
  const RemoteProductsByShopEvent();

  @override
  List<Object> get props => [];
}

class GetProductsByShop extends RemoteProductsByShopEvent {
  final String shopGuid;
  const GetProductsByShop(this.shopGuid);
}
