import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_new_products.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_new_products_event.dart';
part 'remote_new_products_state.dart';

class RemoteNewProductsBloc
    extends Bloc<RemoteNewProductsEvent, RemoteNewProductsState> {
  final GetNewProductsUseCase _getNewProductsUseCase;
  RemoteNewProductsBloc(this._getNewProductsUseCase)
      : super(RemoteNewProductsInitial()) {
    on<GetNewProducts>(onGetNewProducts);
  }

  void onGetNewProducts(
      GetNewProducts event, Emitter<RemoteNewProductsState> emit) async {
    final dataState = await _getNewProductsUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteNewProductsLoaded(dataState.data!));
    } else if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emit(RemoteNewProductsLoadedEmpty());
    } else if (dataState is DataFailed) {
      emit(RemoteNewProductsError(dataState.error!));
    } else {
      emit(RemoteNewProductsError(DioException(
          error: "onGetProducts Unhandled case",
          requestOptions: RequestOptions(path: 'products/new'))));
    }
  }
}
