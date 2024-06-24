import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_products.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_product_event.dart';
part 'remote_product_state.dart';

class RemoteProductBloc extends Bloc<RemoteProductEvent, RemoteProductState> {
  final GetProductsUseCase _getProductsUseCase;

  RemoteProductBloc(this._getProductsUseCase) : super(RemoteProductInitial()) {
    on<GetProducts>(onGetProducts);
  }

  Future<void> fetchProducts(
    Future<DataState<List<ProductEntity>>> Function() fetchUseCase,
    Emitter<RemoteProductState> emit,
    String errorMessagePath,
  ) async {
    final dataState = await fetchUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteProductLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteProductError(dataState.error!));
    } else {
      emit(RemoteProductError(DioException(
          error: "onGetProducts Unhandled case",
          requestOptions: RequestOptions(path: errorMessagePath))));
    }
  }

  void onGetProducts(
      GetProducts event, Emitter<RemoteProductState> emit) async {
    await fetchProducts(_getProductsUseCase.call, emit, 'products');
  }
}
