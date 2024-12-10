import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/orders/data/datasource/dto/create_order_dto.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/domain/usecases/create_order.dart';
import 'package:coffee_start/features/orders/domain/usecases/get_orders.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_orders_event.dart';
part 'remote_orders_state.dart';

class RemoteOrdersBloc extends Bloc<RemoteOrdersEvent, RemoteOrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final CreateOrdersUseCase _createOrdersUseCase;
  RemoteOrdersBloc(this._getOrdersUseCase, this._createOrdersUseCase)
      : super(RemoteOrdersInitial()) {
    on<GetOrders>(onGetOrders);
    on<CreateOrder>(onCreateOrder);
  }

  FutureOr<void> onGetOrders(
      GetOrders event, Emitter<RemoteOrdersState> emit) async {
    emit(RemoteOrdersLoading());
    final dataState = await _getOrdersUseCase();
    if (dataState is DataSuccess) {
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
    final orderItems = event.checkoutData.orderItemsInfo.orderItems
        .map((item) => CartProductDto(
            quantity: item.quantity, productGuid: item.product.guid))
        .toList();
    final payload = CreateOrderDto(
        shopGuid: event.checkoutData.shopGuid,
        phone: event.checkoutData.contactInfo.phone,
        address: event.checkoutData.contactInfo.address,
        paymentMethod: event.checkoutData.paymentInfo.paymentMethod,
        totalPrice: event.checkoutData.orderItemsInfo.totalPrice,
        orderItems: orderItems);

    final dataState = await _createOrdersUseCase(params: payload);

    if (dataState is DataSuccess) {
      if (payload.paymentMethod == PaymentMethods.card) {
        emit(CardPaymentOrderCreated(dataState.data!.formUrl!));
      } else {
        emit(OrderCreated(dataState.data!.orderNumber));
      }
    } else if (dataState is DataFailed) {
      print('createOrder DataFailed:');
      print(dataState.error?.response);
      emit(RemoteOrdersError(dataState.error!));
    } else {
      emit(RemoteOrdersError(DioException(
          error: "onCreateOrder Unhandled case",
          requestOptions: RequestOptions(path: 'order'))));
    }
  }
}
