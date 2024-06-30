part of 'remote_shops_bloc.dart';

sealed class RemoteShopsState extends Equatable {
  const RemoteShopsState();

  @override
  List<Object> get props => [];
}

final class RemoteShopsInitial extends RemoteShopsState {}

final class RemoteShopsLoading extends RemoteShopsState {}

final class RemoteShopsLoaded extends RemoteShopsState {
  final List<ShopEntity> shops;
  const RemoteShopsLoaded(this.shops);

  @override
  List<Object> get props => [shops];
}

final class RemoteShopsError extends RemoteShopsState {
  final DioException error;
  const RemoteShopsError(this.error);

  @override
  List<Object> get props => [error];
}
