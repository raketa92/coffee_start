part of 'remote_orders_bloc.dart';

sealed class RemoteOrdersEvent extends Equatable {
  const RemoteOrdersEvent();

  @override
  List<Object> get props => [];
}

class GetOrders extends RemoteOrdersEvent {
  const GetOrders();
}
