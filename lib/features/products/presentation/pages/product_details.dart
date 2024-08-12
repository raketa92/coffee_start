import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/cart/domain/usecases/cart_params.dart';
import 'package:coffee_start/features/cart/presentation/bloc/local/cart_items/cart_items_local_bloc.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/product_details/remote_product_details_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  final int productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<RemoteProductDetailsBloc>()..add(GetProduct(widget.productId)),
      child: BlocBuilder<RemoteProductDetailsBloc, RemoteProductDetailsState>(
          builder: (context, state) {
        if (state is RemoteProductDetailsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteProductDetailsError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (state is RemoteProductDetailsLoaded) {
          ProductEntity product = state.product;
          return productDetailsBlock(product);
        }

        return Container();
      }),
    );
  }

  Widget productDetailsBlock(ProductEntity product) {
    return Scaffold(
      appBar: _productAppBar(),
      body: _productBody(product),
      floatingActionButton: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: BlocBuilder<CartItemsLocalBloc, CartItemsLocalState>(
          builder: (cartItemsLocalcontext, state) {
            CartItemEntity? matchingCartItem;
            bool isAdded = false;
            if (state is CartItemsLocalLoaded) {
              try {
                matchingCartItem = state.cartItems.firstWhere((item) =>
                    item.products.any(
                        (itemProduct) => itemProduct.product.id == product.id));
                isAdded = true;
              } catch (e) {
                matchingCartItem = null;
                isAdded = false;
              }
            }
            final buttonText = isAdded ? 'Remove from Cart' : 'Add to Cart';

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {
                if (isAdded && matchingCartItem != null) {
                  final cartParams = CartParams(
                      shopId: product.shopId,
                      product: CartItemProductEntity(product: product));
                  cartItemsLocalcontext
                      .read<CartItemsLocalBloc>()
                      .add(RemoveFromCart(cartParams));
                } else {
                  final newCartItemProduct =
                      CartItemProductEntity(product: product);
                  final cartParams = CartParams(
                      shopId: product.shopId, product: newCartItemProduct);
                  cartItemsLocalcontext
                      .read<CartItemsLocalBloc>()
                      .add(AddToCart(cartParams));
                }
              },
              child: Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _productAppBar() {
    return AppBar(
      title: const Text(
        'Product Detail',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        IconButton(
            iconSize: 32,
            onPressed: () => {},
            icon: const Icon(Icons.more_vert_outlined)),
      ],
    );
  }

  _productBody(ProductEntity product) {
    final imageUrl = '$apiBaseUrl/${product.image}';
    final name = product.name;
    final price = product.price;
    final rating = product.rating;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: CachedNetworkImage(
                height: 160,
                width: 160,
                imageUrl: imageUrl,
                cacheManager: CustomCacheManager.getInstance(),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        '\$ $price',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildRatingStars(rating),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$rating (56 reviews)',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(
        Icons.star,
        color: Colors.yellow,
      ));
    }
    if (hasHalfStar) {
      stars.add(const Icon(
        Icons.star_half,
        color: Colors.yellow,
      ));
    }

    while (stars.length < 5) {
      stars.add(const Icon(
        Icons.star_border,
        color: Colors.yellow,
      ));
    }

    return Row(
      children: stars,
    );
  }
}
