import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/domain/usecases/get_orders.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_orders_event.dart';
part 'remote_orders_state.dart';

class RemoteOrdersBloc extends Bloc<RemoteOrdersEvent, RemoteOrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  RemoteOrdersBloc(this._getOrdersUseCase) : super(RemoteOrdersInitial()) {
    on<GetOrders>(onGetOrders);
  }

  FutureOr<void> onGetOrders(
      GetOrders event, Emitter<RemoteOrdersState> emit) async {
    final dataState = await _getOrdersUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteOrdersLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteOrdersError(dataState.error!));
    } else {
      emit(RemoteOrdersError(DioException(
          error: "onGetShops Unhandled case",
          requestOptions: RequestOptions(path: 'shops'))));
    }
  }
}
