import 'package:bloc/bloc.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/categories/domain/entities/category.dart';
import 'package:coffee_start/features/categories/domain/usecases/get_categories.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_category_event.dart';
part 'remote_category_state.dart';

class RemoteCategoryBloc
    extends Bloc<RemoteCategoryEvent, RemoteCategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  RemoteCategoryBloc(this._getCategoriesUseCase)
      : super(RemoteCategoryLoading()) {
    on<GetCategories>(onGetCategories);
  }

  void onGetCategories(
      GetCategories event, Emitter<RemoteCategoryState> emit) async {
    final dataState = await _getCategoriesUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteCategoryLoaded(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteCategoryError(dataState.error!));
    } else {
      emit(RemoteCategoryError(DioException(
          error: "onGetProducts Unhandled case",
          requestOptions: RequestOptions(path: 'categories'))));
    }
  }
}
