import 'dart:convert';

import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/cart/data/models/cart_item.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/cart/domain/repository/cart_repository_local.dart';
import 'package:coffee_start/features/cart/domain/usecases/cart_params.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CartItemRepositoryLocalImpl implements CartItemRepositoryLocal {
  final HydratedStorage storage;

  CartItemRepositoryLocalImpl({required this.storage});

  @override
  Future<void> addToCart(CartParams cartParams) async {
    final cartItems = await getCartItems();
    final shopId = cartParams.shopId;
    final cartItemProduct = cartParams.product;

    final index = cartItems.indexWhere((element) => element.shopId == shopId);

    if (index != -1) {
      final existingCartItem = cartItems[index];

      final updatedCartProducts =
          List<CartItemProductEntity>.from(existingCartItem.products);

      final productIndex = updatedCartProducts
          .indexWhere((item) => item.product.id == cartItemProduct.product.id);

      if (productIndex != -1) {
        final currentCartProduct = updatedCartProducts[productIndex];
        updatedCartProducts[productIndex] = CartItemProductEntity(
            product: currentCartProduct.product,
            quantity: currentCartProduct.quantity + cartItemProduct.quantity);
      } else {
        updatedCartProducts.add(cartItemProduct);
      }

      cartItems[index] = CartItemModel.fromEntity(CartItemEntity(
        shopId: existingCartItem.shopId,
        products: updatedCartProducts,
        totalPrice: updatedCartProducts.fold(
          0.0,
          (sum, item) => sum + item.product.price * item.quantity,
        ),
      ));
    } else {
      cartItems.add(CartItemModel.fromEntity(CartItemEntity(
        shopId: shopId,
        products: [cartItemProduct],
        totalPrice: cartItemProduct.product.price * cartItemProduct.quantity,
      )));
    }

    await saveCartItemProducts(cartItems);
  }

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final jsonString = storage.read(cartItemsLocalStorageKey);
    if (jsonString != null) {
      try {
        final List<dynamic> decodedJson = json.decode(jsonString) as List;
        return decodedJson
            .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print("Error decoding cart items: $e");
        return [];
      }
    }
    return [];
  }

  @override
  Future<void> removeFromCart(CartParams cartParams) async {
    final cartItems = await getCartItems();
    final shopId = cartParams.shopId;
    final cartItemproduct = cartParams.product;

    final index = cartItems.indexWhere((element) => element.shopId == shopId);

    if (index != -1) {
      final existingCartItem = cartItems[index];

      final updatedCartProducts = List<CartItemProductEntity>.from(
          existingCartItem.products)
        ..removeWhere((item) => item.product.id == cartItemproduct.product.id);

      if (updatedCartProducts.isEmpty) {
        cartItems.removeAt(index);
      } else {
        final cartItemModel = CartItemModel.fromEntity(CartItemEntity(
            shopId: existingCartItem.shopId,
            products: updatedCartProducts,
            totalPrice: updatedCartProducts.fold(
                0.0, (sum, item) => sum + item.product.price * item.quantity)));
        cartItems[index] = cartItemModel;
      }
    }

    await saveCartItemProducts(cartItems);
  }

  @override
  Future<void> saveCartItemProducts(List<CartItemEntity> cartItems) async {
    final List<Map<String, dynamic>> cartItemsJson = cartItems
        .map((item) => CartItemModel.fromEntity(item).toJson())
        .toList();
    final jsonString = json.encode(cartItemsJson);
    await storage.write(cartItemsLocalStorageKey, jsonString);
  }
}
