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
