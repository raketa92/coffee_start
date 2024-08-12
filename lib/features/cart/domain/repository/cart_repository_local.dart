import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/cart/domain/usecases/cart_params.dart';

abstract class CartItemRepositoryLocal {
  Future<List<CartItemEntity>> getCartItems();
  Future<void> addToCart(CartParams cartParams);
  Future<void> removeFromCart(CartParams cartParams);
  Future<void> saveCartItemProducts(List<CartItemEntity> cartItems);
}
