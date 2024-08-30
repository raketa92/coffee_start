part of 'cart_items_local_bloc.dart';

sealed class CartItemsLocalState extends Equatable {
  const CartItemsLocalState();

  @override
  List<Object> get props => [];
}

final class CartItemsLocalInitial extends CartItemsLocalState {}

final class CartItemsLocalLoading extends CartItemsLocalState {}

final class CartItemsLocalLoaded extends CartItemsLocalState {
  final List<CartItemEntity> cartItems;
  const CartItemsLocalLoaded({required this.cartItems});

  CartItemsLocalLoaded copyWith({required List<CartItemEntity> cartItems}) =>
      CartItemsLocalLoaded(cartItems: cartItems);

  @override
  List<Object> get props => [cartItems];
}

final class CartItemLocalLoaded extends CartItemsLocalState {
  final CartItemEntity cartItem;
  const CartItemLocalLoaded({required this.cartItem});

  CartItemLocalLoaded copyWith({required CartItemEntity cartItem}) =>
      CartItemLocalLoaded(cartItem: cartItem);

  @override
  List<Object> get props => [cartItem];
}

class CartItemsLocalError extends CartItemsLocalState {
  final String message;
  const CartItemsLocalError({required this.message});

  @override
  List<Object> get props => [message];
}
