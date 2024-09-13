import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/card/domain/entities/card.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/domain/usecases/create_order.dart';
import 'package:coffee_start/features/orders/domain/usecases/get_orders.dart';
import 'package:coffee_start/features/orders/domain/usecases/pay_order.dart';
import 'package:coffee_start/features/orders/domain/usecases/pay_order_params.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_orders_event.dart';
part 'remote_orders_state.dart';

class RemoteOrdersBloc extends Bloc<RemoteOrdersEvent, RemoteOrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final CreateOrdersUseCase _createOrdersUseCase;
  final PayOrderUseCase _payOrderUseCase;
  RemoteOrdersBloc(
      this._getOrdersUseCase, this._createOrdersUseCase, this._payOrderUseCase)
      : super(RemoteOrdersInitial()) {
    on<GetOrders>(onGetOrders);
    on<CreateOrder>(onCreateOrder);
    on<PayOrder>(onPayOrder);
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
          error: "onGetOrders Unhandled case",
          requestOptions: RequestOptions(path: 'orders'))));
    }
  }

  FutureOr<void> onCreateOrder(
      CreateOrder event, Emitter<RemoteOrdersState> emit) async {
    emit(RemoteOrdersLoading());
    final dataState = await _createOrdersUseCase(params: event.checkoutData);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(OrderCreated(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteOrdersError(dataState.error!));
    } else {
      emit(RemoteOrdersError(DioException(
          error: "onCreateOrder Unhandled case",
          requestOptions: RequestOptions(path: 'order'))));
    }
  }

  FutureOr<void> onPayOrder(
      PayOrder event, Emitter<RemoteOrdersState> emit) async {
    emit(RemoteOrdersLoading());
    final dataState = await _payOrderUseCase(
        params: PayOrderParams(event.orderId, event.cardEntity));
    if (dataState is DataSuccess) {
      emit(OrderPaid(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteOrdersError(dataState.error!));
    } else {
      emit(RemoteOrdersError(DioException(
          error: "onPayOrder Unhandled case",
          requestOptions: RequestOptions(path: 'order/pay'))));
    }
  }
}
