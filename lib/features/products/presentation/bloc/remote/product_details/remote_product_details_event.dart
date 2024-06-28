part of 'remote_product_details_bloc.dart';

sealed class RemoteProductDetailsEvent extends Equatable {
  const RemoteProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetProduct extends RemoteProductDetailsEvent {
  final int productId;
  const GetProduct(this.productId);
}