import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/shops/domain/entities/shop.dart';
import 'package:coffee_start/features/shops/domain/usecases/get_shops.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_shops_event.dart';
part 'remote_shops_state.dart';

class RemoteShopsBloc extends Bloc<RemoteShopsEvent, RemoteShopsState> {
  final GetShopsUseCase _getShopsUseCase;
  RemoteShopsBloc(this._getShopsUseCase) : super(RemoteShopsInitial()) {
    on<GetShops>(onGetShops);
  }

  void onGetShops(GetShops event, Emitter<RemoteShopsState> emit) async {
    final dataState = await _getShopsUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteShopsLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteShopsError(dataState.error!));
    } else {
      emit(RemoteShopsError(DioException(
          error: "onGetShops Unhandled case",
          requestOptions: RequestOptions(path: 'shops'))));
    }
  }
}
