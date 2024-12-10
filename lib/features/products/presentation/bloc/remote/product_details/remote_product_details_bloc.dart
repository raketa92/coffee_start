import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_product.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_product_details_event.dart';
part 'remote_product_details_state.dart';

class RemoteProductDetailsBloc
    extends Bloc<RemoteProductDetailsEvent, RemoteProductDetailsState> {
  final GetProductUseCase _getProductUseCase;
  RemoteProductDetailsBloc(this._getProductUseCase)
      : super(RemoteProductDetailsInitial()) {
    on<GetProduct>(onGetProduct);
  }

  void onGetProduct(
      GetProduct event, Emitter<RemoteProductDetailsState> emit) async {
    final dataState = await _getProductUseCase(params: event.productGuid);
    if (dataState is DataSuccess) {
      emit(RemoteProductDetailsLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteProductDetailsError(dataState.error!));
    } else {
      emit(RemoteProductDetailsError(DioException(
          error: "onGetProducts Unhandled case",
          requestOptions: RequestOptions(path: 'products/{productId}'))));
    }
  }
}
