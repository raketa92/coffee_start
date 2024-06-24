part of 'remote_popular_products_bloc.dart';

sealed class RemotePopularProductsEvent extends Equatable {
  const RemotePopularProductsEvent();

  @override
  List<Object> get props => [];
}

class GetPopularProducts extends RemotePopularProductsEvent {
  const GetPopularProducts();
}
