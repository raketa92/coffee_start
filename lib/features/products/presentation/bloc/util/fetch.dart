import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/remote_product_bloc.dart';
import 'package:dio/dio.dart';

Future<void> fetchProducts(
  Future<DataState<List<ProductEntity>>> Function() fetchUseCase,
  Emitter emit,
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
