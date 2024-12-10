import 'dart:async';

import 'package:coffee_start/features/products/data/models/product.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/domain/usecases/add_liked_product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_liked_products.dart';
import 'package:coffee_start/features/products/domain/usecases/remove_liked_product.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'liked_products_local_event.dart';
part 'liked_products_local_state.dart';

class LikedProductsLocalBloc
    extends Bloc<LikedProductsLocalEvent, LikedProductsLocalState>
    with HydratedMixin {
  final GetLikedProductsUseCase _getLikedProductsUseCase;
  final AddLikedProductUseCase _addLikedProductUseCase;
  final RemoveLikedProductUseCase _removeLikedProductUseCase;
  LikedProductsLocalBloc(this._getLikedProductsUseCase,
      this._addLikedProductUseCase, this._removeLikedProductUseCase)
      : super(LikedProductsInitial()) {
    on<FetchLikedProducts>(onFetchLikedProducts);
    on<AddLikedProduct>(onAddLikedProduct);
    on<RemoveLikedProduct>(onRemoveLikedProduct);
  }

  void onFetchLikedProducts(
      FetchLikedProducts event, Emitter<LikedProductsLocalState> emit) async {
    emit(LikedProductsLoading());
    try {
      final data = await _getLikedProductsUseCase();
      if (data.isNotEmpty) {
        emit(LikedProductsLoaded(likedProducts: data));
      } else {
        emit(const LikedProductsLoaded(likedProducts: []));
      }
    } catch (e) {
      emit(LikedProductsError(message: e.toString()));
    }
  }

  @override
  LikedProductsLocalState? fromJson(Map<String, dynamic> json) {
    try {
      final likedProducts = (json['likedProducts'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
      return LikedProductsLoaded(likedProducts: likedProducts);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LikedProductsLocalState state) {
    if (state is LikedProductsLoaded) {
      return {
        'likedProducts': state.likedProducts
            .map((product) => ProductModel.fromEntity(product).toJson())
            .toList()
      };
    }
    return null;
  }

  FutureOr<void> onAddLikedProduct(
      AddLikedProduct event, Emitter<LikedProductsLocalState> emit) async {
    if (state is LikedProductsLoaded) {
      final currentState = state as LikedProductsLoaded;
      final updatedProducts =
          List<ProductEntity>.from(currentState.likedProducts)
            ..add(event.likedProduct);
      await _addLikedProductUseCase(params: event.likedProduct);
      emit(currentState.copyWith(likedProducts: updatedProducts));
    }
  }

  FutureOr<void> onRemoveLikedProduct(
      RemoveLikedProduct event, Emitter<LikedProductsLocalState> emit) async {
    if (state is LikedProductsLoaded) {
      final currentState = state as LikedProductsLoaded;
      final updatedProducts =
          List<ProductEntity>.from(currentState.likedProducts)
            ..removeWhere((product) => product.guid == event.likedProduct.guid);
      await _removeLikedProductUseCase(params: event.likedProduct);
      emit(currentState.copyWith(likedProducts: updatedProducts));
    }
  }
}
