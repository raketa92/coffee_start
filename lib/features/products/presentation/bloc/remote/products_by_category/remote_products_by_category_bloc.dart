import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_products_by_category.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_products_by_category_event.dart';
part 'remote_products_by_category_state.dart';

class RemoteProductsByCategoryBloc
    extends Bloc<RemoteProductsByCategoryEvent, RemoteProductsByCategoryState> {
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  RemoteProductsByCategoryBloc(this._getProductsByCategoryUseCase)
      : super(RemoteProductsByCategoryInitial()) {
    on<GetProductsByCategory>(onGetProductsByCategory);
  }

  void onGetProductsByCategory(GetProductsByCategory event,
      Emitter<RemoteProductsByCategoryState> emit) async {
    final dataState =
        await _getProductsByCategoryUseCase(params: event.categoryGuid);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteProductsByCategoryLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteProductsByCategoryError(dataState.error!));
    } else {
      emit(RemoteProductsByCategoryError(DioException(
          error: "onGetProducts Unhandled case",
          requestOptions: RequestOptions(path: 'products/by-category'))));
    }
  }
}
