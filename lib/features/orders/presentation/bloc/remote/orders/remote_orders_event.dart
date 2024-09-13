part of 'remote_orders_bloc.dart';

sealed class RemoteOrdersEvent extends Equatable {
  const RemoteOrdersEvent();

  @override
  List<Object> get props => [];
}

class GetOrders extends RemoteOrdersEvent {
  const GetOrders();
}

class CreateOrder extends RemoteOrdersEvent {
  final CheckoutData checkoutData;
  const CreateOrder(this.checkoutData);
}

class PayOrder extends RemoteOrdersEvent {
  final String orderId;
  final CardEntity cardEntity;
  const PayOrder(this.orderId, this.cardEntity);
}
