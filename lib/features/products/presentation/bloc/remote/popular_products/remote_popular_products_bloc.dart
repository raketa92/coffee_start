import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_popular_products.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_popular_products_event.dart';
part 'remote_popular_products_state.dart';

class RemotePopularProductsBloc
    extends Bloc<RemotePopularProductsEvent, RemotePopularProductsState> {
  final GetPopularProductsUseCase _getPopularProductsUseCase;
  RemotePopularProductsBloc(this._getPopularProductsUseCase)
      : super(RemotePopularProductsInitial()) {
    on<GetPopularProducts>(onGetPopularProducts);
  }

  void onGetPopularProducts(GetPopularProducts event,
      Emitter<RemotePopularProductsState> emit) async {
    final dataState = await _getPopularProductsUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemotePopularProductsLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemotePopularProductsError(dataState.error!));
    } else {
      emit(RemotePopularProductsError(DioException(
          error: "onGetProducts Unhandled case",
          requestOptions: RequestOptions(path: 'products/popular'))));
    }
  }
}
