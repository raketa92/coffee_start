part of 'remote_orders_bloc.dart';

sealed class RemoteOrdersState extends Equatable {
  const RemoteOrdersState();

  @override
  List<Object> get props => [];
}

final class RemoteOrdersInitial extends RemoteOrdersState {}

final class RemoteOrdersLoading extends RemoteOrdersState {}

final class RemoteOrdersLoaded extends RemoteOrdersState {
  final List<OrderEntity> orders;
  const RemoteOrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

final class RemoteOrdersError extends RemoteOrdersState {
  final DioException error;
  const RemoteOrdersError(this.error);

  @override
  List<Object> get props => [error];
}

final class OrderCreated extends RemoteOrdersState {
  final String orderId;
  const OrderCreated(this.orderId);

  @override
  List<Object> get props => [orderId];
}

final class OrderSmsConfirmed extends RemoteOrdersState {
  final String sms;
  const OrderSmsConfirmed(this.sms);

  @override
  List<Object> get props => [sms];
}

final class OrderSmsConfirmError extends RemoteOrdersState {
  final DioException error;
  const OrderSmsConfirmError(this.error);

  @override
  List<Object> get props => [error];
}
