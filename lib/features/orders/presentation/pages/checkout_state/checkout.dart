import 'package:coffee_start/core/widgets/cart_product_list.dart';
import 'package:coffee_start/features/cart/presentation/bloc/local/cart_items/cart_items_local_bloc.dart';
import 'package:coffee_start/features/orders/domain/entities/checkout.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/checkout/local_checkout_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutForm extends StatefulWidget {
  final String shopGuid;
  final LocalCheckoutBloc checkoutBloc;
  const CheckoutForm(
      {super.key, required this.shopGuid, required this.checkoutBloc});

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: widget.checkoutBloc,
        ),
        BlocProvider(
          create: (context) =>
              sl<CartItemsLocalBloc>()..add(GetCartItemByShop(widget.shopGuid)),
        ),
      ],
      child: BlocBuilder<CartItemsLocalBloc, CartItemsLocalState>(
          builder: (context, cartItemState) {
        if (cartItemState is CartItemsLocalLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (cartItemState is CartItemsLocalError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (cartItemState is CartItemLocalLoaded) {
          return BlocBuilder<LocalCheckoutBloc, LocalCheckoutState>(
              bloc: widget.checkoutBloc,
              builder: (context, checkoutDataState) {
                if (checkoutDataState is LocalCheckoutLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (checkoutDataState is LocalCheckoutError) {
                  return const Center(child: Icon(Icons.refresh));
                }
                if (checkoutDataState is LocalCheckoutLoaded) {
                  final orderItemsInfo = OrderItemsInfo(
                      totalPrice: cartItemState.cartItem.totalPrice,
                      orderItems: cartItemState.cartItem.products);
                  widget.checkoutBloc.add(UpdateOrderItemsInfo(orderItemsInfo));
                  return checkoutView(cartItemState);
                }
                return Container();
              });
        }

        return Container();
      }),
    );
  }

  Widget checkoutView(CartItemLocalLoaded state) {
    final item = state.cartItem;
    final subTotal = item.totalPrice;
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
