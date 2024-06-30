part of 'remote_shops_bloc.dart';

sealed class RemoteShopsEvent extends Equatable {
  const RemoteShopsEvent();

  @override
  List<Object> get props => [];
}

class GetShops extends RemoteShopsEvent {
  const GetShops();
}
