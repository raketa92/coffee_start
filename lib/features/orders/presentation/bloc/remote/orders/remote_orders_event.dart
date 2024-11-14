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

class ConfirmSmsOrder extends RemoteOrdersEvent {
  final String sms;
  final String orderNumber;
  const ConfirmSmsOrder(this.sms, this.orderNumber);
}
