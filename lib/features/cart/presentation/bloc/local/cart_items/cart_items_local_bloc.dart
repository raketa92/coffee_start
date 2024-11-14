import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_start/features/cart/data/models/cart_item.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/cart/domain/usecases/add_to_cart.dart';
import 'package:coffee_start/features/cart/domain/usecases/cart_params.dart';
import 'package:coffee_start/features/cart/domain/usecases/get_cart_items.dart';
import 'package:coffee_start/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:coffee_start/features/cart/domain/usecases/save_cart_items.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'cart_items_local_event.dart';
part 'cart_items_local_state.dart';

class CartItemsLocalBloc extends Bloc<CartItemsLocalEvent, CartItemsLocalState>
    with HydratedMixin {
  final GetCartItemsUseCase _getCartItemsUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final SaveCartItemsUseCase _saveCartItemsUseCase;
  CartItemsLocalBloc(this._addToCartUseCase, this._getCartItemsUseCase,
      this._removeFromCartUseCase, this._saveCartItemsUseCase)
      : super(CartItemsLocalInitial()) {
    on<GetCartItems>(onGetCartItems);
    on<AddToCart>(onAddToCart);
    on<RemoveFromCart>(onRemoveFromCart);
    on<IncreaseQuantity>(onIncreaseQuantity);
    on<DecreaseQuantity>(onDecreaseQuantity);
    on<GetCartItemByShop>(onGetCartItemByShop);
  }

  @override
  CartItemsLocalState? fromJson(Map<String, dynamic> json) {
    try {
      final cartItems = (json['cartItems'] as List)
          .map((item) => CartItemModel.fromJson(item).toEntity())
          .toList();
      return CartItemsLocalLoaded(cartItems: cartItems);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CartItemsLocalState state) {
    if (state is CartItemsLocalLoaded) {
      return {
        'cartItems': state.cartItems
            .map((item) => CartItemModel.fromEntity(item).toJson())
            .toList()
      };
    }
    return null;
  }

  FutureOr<void> onGetCartItems(
      GetCartItems event, Emitter<CartItemsLocalState> emit) async {
    emit(CartItemsLocalLoading());
    try {
      final data = await _getCartItemsUseCase();
      if (data.isNotEmpty) {
        emit(CartItemsLocalLoaded(cartItems: data));
      } else {
        emit(const CartItemsLocalLoaded(cartItems: []));
      }
    } catch (e) {
      emit(CartItemsLocalError(message: e.toString()));
    }
  }

  FutureOr<void> onAddToCart(
      AddToCart event, Emitter<CartItemsLocalState> emit) async {
    if (state is CartItemsLocalLoaded) {
      final currentState = state as CartItemsLocalLoaded;
      await _addToCartUseCase(
          params: CartParams(
              shopGuid: event.cartParams.shopGuid,
              product: event.cartParams.product));
      final updatedCartItems = await _getCartItemsUseCase();
      emit(currentState.copyWith(cartItems: updatedCartItems));
    }
  }

  FutureOr<void> onRemoveFromCart(
      RemoveFromCart event, Emitter<CartItemsLocalState> emit) async {
    if (state is CartItemsLocalLoaded) {
      final currentState = state as CartItemsLocalLoaded;
      for (var item in event.cartParams) {
        await _removeFromCartUseCase(
            params: CartParams(shopGuid: item.shopGuid, product: item.product));
      }
      final updatedCartItems = await _getCartItemsUseCase();
      emit(currentState.copyWith(cartItems: updatedCartItems));
    }
  }

  FutureOr<void> onIncreaseQuantity(
      IncreaseQuantity event, Emitter<CartItemsLocalState> emit) async {
    if (state is CartItemsLocalLoaded) {
      final currentState = state as CartItemsLocalLoaded;
      final updatedCartItems = currentState.cartItems.map((item) {
        return CartItemEntity(
            shopGuid: item.shopGuid,
            products: item.products.map((productEntity) {
              if (productEntity.product.guid ==
                  event.cartItemProduct.product.guid) {
                return CartItemProductEntity(
                    product: productEntity.product,
                    quantity: productEntity.quantity + 1);
              }
              return productEntity;
            }).toList(),
            totalPrice: item.products.fold(
                0.0,
                (sum, item) =>
                    sum +
                    item.product.price *
                        (item.product.guid == event.cartItemProduct.product.guid
                            ? item.quantity + 1
                            : item.quantity)));
      }).toList();
      await _saveCartItemsUseCase(params: updatedCartItems);
      emit(currentState.copyWith(cartItems: updatedCartItems));
    }
  }

  FutureOr<void> onDecreaseQuantity(
      DecreaseQuantity event, Emitter<CartItemsLocalState> emit) async {
    if (state is CartItemsLocalLoaded) {
      final currentState = state as CartItemsLocalLoaded;
      final updatedCartItems = currentState.cartItems.map((item) {
        if (item.products.any((productEntity) =>
            productEntity.product.guid == event.cartItemProduct.product.guid)) {
          final updatedProducts = item.products.map((product) {
            if (product.product.guid == event.cartItemProduct.product.guid) {
              return CartItemProductEntity(
                  product: product.product,
                  quantity: product.quantity > 1
                      ? product.quantity - 1
                      : product.quantity);
            }
            return product;
          }).toList();
          final newTotalPrice = updatedProducts.fold(0.0, (sum, productEntity) {
            return sum + productEntity.product.price * productEntity.quantity;
          });

          return CartItemEntity(
              shopGuid: item.shopGuid,
              products: updatedProducts,
              totalPrice: newTotalPrice);
        }
        return item;
      }).toList();

      await _saveCartItemsUseCase(params: updatedCartItems);
      emit(currentState.copyWith(cartItems: updatedCartItems));
    }
  }

  Future<FutureOr<void>> onGetCartItemByShop(
      GetCartItemByShop event, Emitter<CartItemsLocalState> emit) async {
    if (state is! CartItemsLocalLoaded) {
      emit(CartItemsLocalLoading());
      try {
        final data = await _getCartItemsUseCase();
        emit(CartItemsLocalLoaded(cartItems: data));
      } catch (e) {
        emit(CartItemsLocalError(message: e.toString()));
      }
    }
    if (state is CartItemsLocalLoaded) {
      final currentState = state as CartItemsLocalLoaded;
      final result = currentState.cartItems
          .where((element) => element.shopGuid == event.shopGuid)
          .firstOrNull;
      if (result != null) {
        emit(CartItemLocalLoaded(cartItem: result));
      } else {
        emit(const CartItemsLocalError(message: "cart item by shop not found"));
      }
    }
  }
}
