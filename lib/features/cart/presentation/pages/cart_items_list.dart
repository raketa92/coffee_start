import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/constants/routes.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/cart/domain/usecases/cart_params.dart';
import 'package:coffee_start/features/cart/presentation/bloc/local/cart_items/cart_items_local_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemsList extends StatefulWidget {
  const CartItemsList({super.key});

  @override
  State<CartItemsList> createState() => _CartItemsListState();
}

class _CartItemsListState extends State<CartItemsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemsLocalBloc, CartItemsLocalState>(
        builder: (context, state) {
      if (state is CartItemsLocalLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is CartItemsLocalError) {
        return const Center(child: Icon(Icons.refresh));
      }

      if (state is CartItemsLocalLoaded) {
        return cartItemsListView(state);
      }

      return Container();
    });
  }

  Widget cartItemsListView(CartItemsLocalLoaded state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart', style: TextStyle(fontSize: 18)),
      ),
      body: _body(state),
    );
  }

  _body(CartItemsLocalLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
          itemCount: state.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = state.cartItems[index];
            final shopId = cartItem.shopId;
            final name = cartItem.shopId;
            final products = cartItem.products;
            final cartItemTotalPrice = cartItem.totalPrice;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shopHeader(shopId),
                _productList(products, cartItem),
                _shopTotalPriceAndCheckout(cartItemTotalPrice, shopId),
                const Divider(
                  thickness: 1,
                ),
              ],
            );
          }),
    );
  }

  _productInfoBlock({required String imageUrl, required String productName}) {
    return Expanded(
      flex: 6,
      child: Row(children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: CachedNetworkImage(
            height: 80,
            width: 100,
            imageUrl: imageUrl,
            cacheManager: CustomCacheManager.getInstance(),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Expanded(
            child: Text('some long name of a product coffee and snacks',
                maxLines: 3)),
      ]),
    );
  }

  _actionBlock(
      {required double price,
      required CartItemProductEntity cartItemProductEntity,
      required CartItemEntity cartItem}) {
    final totalPriceOfProduct = cartItemProductEntity.quantity * price;
    final cartParams = CartParams(
        shopId: cartItem.shopId,
        product: CartItemProductEntity(product: cartItemProductEntity.product));
    return BlocBuilder<CartItemsLocalBloc, CartItemsLocalState>(
      builder: (cartItemsLocalcontext, state) {
        return Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cartItemsLocalcontext
                                .read<CartItemsLocalBloc>()
                                .add(RemoveFromCart(cartParams));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            cartItemsLocalcontext
                                .read<CartItemsLocalBloc>()
                                .add(DecreaseQuantity(cartItemProductEntity));
                          },
                        ),
                        Text(cartItemProductEntity.quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            cartItemsLocalcontext
                                .read<CartItemsLocalBloc>()
                                .add(IncreaseQuantity(cartItemProductEntity));
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text("$totalPriceOfProduct TMT"),
                    )
                  ],
                ),
              ],
            ));
      },
    );
  }

  Widget _shopHeader(int shopId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text('Shop #$shopId',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _productList(
      List<CartItemProductEntity> products, CartItemEntity cartItem) {
    return Column(
      children: products.map((cartItemProduct) {
        final productEntity = cartItemProduct.product;
        final name = productEntity.name;
        final price = productEntity.price;
        final image = productEntity.image;
        final imageUrl = '$apiBaseUrl/$image';
        return Card(
          child: Column(
            children: [
              Row(
                children: [
                  _productInfoBlock(imageUrl: imageUrl, productName: name),
                  _actionBlock(
                      price: price,
                      cartItemProductEntity: cartItemProduct,
                      cartItem: cartItem),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _shopTotalPriceAndCheckout(double totalPrice, int shopId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total: $totalPrice TMT', style: const TextStyle(fontSize: 16)),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, checkoutRoute, arguments: shopId);
            },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
