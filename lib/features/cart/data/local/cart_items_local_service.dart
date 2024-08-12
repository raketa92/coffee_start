import 'package:coffee_start/features/cart/data/models/cart_item.dart';

abstract class CartItemsLocalService {
  Future<List<CartItemModel>> getLikedProducts();
  Future<void> addLikedProduct(CartItemModel cartItem);
  Future<void> removeLikedProduct(CartItemModel producartItemct);
}
