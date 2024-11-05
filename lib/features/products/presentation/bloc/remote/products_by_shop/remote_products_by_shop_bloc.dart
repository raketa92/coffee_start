import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_products_by_shop.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_products_by_shop_event.dart';
part 'remote_products_by_shop_state.dart';

class RemoteProductsByShopBloc
    extends Bloc<RemoteProductsByShopEvent, RemoteProductsByShopState> {
  final GetProductsByShopUseCase _getProductsByShopUseCase;
  RemoteProductsByShopBloc(this._getProductsByShopUseCase)
      : super(RemoteProductsByShopInitial()) {
    on<GetProductsByShop>(onGetProductsByShop);
  }

  void onGetProductsByShop(
      GetProductsByShop event, Emitter<RemoteProductsByShopState> emit) async {
    final dataState = await _getProductsByShopUseCase(params: event.shopGuid);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteProductsByShopLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteProductsByShopError(dataState.error!));
    } else {
      emit(RemoteProductsByShopError(DioException(
          error: "onGetProducts Unhandled case",
          requestOptions: RequestOptions(path: 'products?shopGuid'))));
    }
  }
}
