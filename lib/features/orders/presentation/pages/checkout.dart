import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:coffee_start/features/cart/presentation/bloc/local/cart_items/cart_items_local_bloc.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutForm extends StatefulWidget {
  final int shopId;
  final CheckoutData checkoutData;
  const CheckoutForm(
      {super.key, required this.shopId, required this.checkoutData});

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CartItemsLocalBloc>()..add(GetCartItemByShop(widget.shopId)),
      child: BlocBuilder<CartItemsLocalBloc, CartItemsLocalState>(
          builder: (context, state) {
        if (state is CartItemsLocalLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is CartItemsLocalError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (state is CartItemLocalLoaded) {
          return checkoutView(state);
        }

        return Container();
      }),
    );
  }

  Widget checkoutView(CartItemLocalLoaded state) {
    final item = state.cartItem;
    final subTotal = item.totalPrice;
    widget.checkoutData.totalPrice = subTotal;
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("Summary"),
          items(item),
          Text("Total: $subTotal TMT"),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget items(CartItemEntity item) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 6,
            ),
        shrinkWrap: true,
        itemCount: item.products.length,
        itemBuilder: (context, index) {
          final productName = item.products[index].product.name;
          final image = item.products[index].product.image;
          final imageUrl = '$apiBaseUrl/$image';
          final quantity = item.products[index].quantity;
          final price = item.products[index].product.price;
          final totalProductPrice = price * quantity;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  _productInfoBlock(
                      productName: productName, imageUrl: imageUrl),
                  Text("x$quantity"),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("$totalProductPrice TMT")
                ],
              ),
            ),
          );
        });
  }

  _productInfoBlock({required String imageUrl, required String productName}) {
    return Expanded(
      child: Row(children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: CachedNetworkImage(
            height: 60,
            width: 80,
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
        Expanded(child: Text(productName, maxLines: 3)),
      ]),
    );
  }
}
