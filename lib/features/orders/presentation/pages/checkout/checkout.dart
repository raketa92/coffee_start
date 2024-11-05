import 'package:coffee_start/core/widgets/cart_product_list.dart';
import 'package:coffee_start/features/cart/presentation/bloc/local/cart_items/cart_items_local_bloc.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutForm extends StatefulWidget {
  final String shopGuid;
  final CheckoutData checkoutData;
  const CheckoutForm(
      {super.key, required this.shopGuid, required this.checkoutData});

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CartItemsLocalBloc>()..add(GetCartItemByShop(widget.shopGuid)),
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
          CartProductList(products: item.products),
          Text("Total: $subTotal TMT"),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
