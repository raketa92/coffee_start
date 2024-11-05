import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/shops/domain/entities/shop_products.dart';
import 'package:coffee_start/features/shops/domain/usecases/get_shop_details.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_shop_details_event.dart';
part 'remote_shop_details_state.dart';

class RemoteShopDetailsBloc
    extends Bloc<RemoteShopDetailsEvent, RemoteShopDetailsState> {
  final GetShopDetailsUseCase _getShopDetailsUseCase;
  RemoteShopDetailsBloc(this._getShopDetailsUseCase)
      : super(RemoteShopDetailsInitial()) {
    on<GetShopDetails>(onGetShopDetails);
  }

  void onGetShopDetails(
      GetShopDetails event, Emitter<RemoteShopDetailsState> emit) async {
    final dataState = await _getShopDetailsUseCase(params: event.shopGuid);
    if (dataState is DataSuccess) {
      emit(RemoteShopDetailsLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteShopDetailsError(dataState.error!));
    } else {
      emit(RemoteShopDetailsError(DioException(
          error: "onGetProducts Unhandled case",
          requestOptions: RequestOptions(path: 'shops/{shopId}'))));
    }
  }
}
