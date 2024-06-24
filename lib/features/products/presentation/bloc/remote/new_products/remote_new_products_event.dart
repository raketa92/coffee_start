part of 'remote_new_products_bloc.dart';

sealed class RemoteNewProductsEvent extends Equatable {
  const RemoteNewProductsEvent();

  @override
  List<Object> get props => [];
}

class GetNewProducts extends RemoteNewProductsEvent {
  const GetNewProducts();
}
