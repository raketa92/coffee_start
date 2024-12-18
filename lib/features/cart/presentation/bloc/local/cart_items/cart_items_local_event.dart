part of 'cart_items_local_bloc.dart';

sealed class CartItemsLocalEvent extends Equatable {
  const CartItemsLocalEvent();

  @override
  List<Object> get props => [];
}

class GetCartItems extends CartItemsLocalEvent {
  const GetCartItems();
}

class GetCartItemByShop extends CartItemsLocalEvent {
  final String shopGuid;
  const GetCartItemByShop(this.shopGuid);
}

class AddToCart extends CartItemsLocalEvent {
  final CartParams cartParams;
  const AddToCart(this.cartParams);
}

class RemoveFromCart extends CartItemsLocalEvent {
  final List<CartParams> cartParams;
  const RemoveFromCart(this.cartParams);
}

class IncreaseQuantity extends CartItemsLocalEvent {
  final CartItemProductEntity cartItemProduct;
  const IncreaseQuantity(this.cartItemProduct);

  @override
  List<Object> get props => [cartItemProduct];
}

class DecreaseQuantity extends CartItemsLocalEvent {
  final CartItemProductEntity cartItemProduct;
  const DecreaseQuantity(this.cartItemProduct);

  @override
  List<Object> get props => [cartItemProduct];
}
