import 'package:coffee_start/features/orders/presentation/bloc/remote/orders/remote_orders_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RemoteOrdersBloc>()..add(const GetOrders()),
      child: BlocBuilder<RemoteOrdersBloc, RemoteOrdersState>(
        builder: (context, state) {
          if (state is RemoteOrdersLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is RemoteOrdersError) {
            return const Center(child: Icon(Icons.refresh));
          }
          if (state is RemoteOrdersLoaded) {
            return ordersListView(state);
          }
          return Container();
        },
      ),
    );
  }

  Widget ordersListView(RemoteOrdersLoaded state) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(state),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text(
        'Cart',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  _body(RemoteOrdersLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      // child: GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //         crossAxisSpacing: 2,
      //         mainAxisSpacing: 2,
      //         childAspectRatio: 3 / 4),
      //     itemCount: state.orders.length,
      //     itemBuilder: (context, index) {
      //       final order = state.orders[index];
      //       final shopName = order.shopName;
      //       final rating = order.rating;
      //       final totalPrice = order.totalPrice;
      //       final products = order.products;
      //       return Padding(
      //           padding: const EdgeInsets.only(left: 10, right: 10),
      //           child: GestureDetector(
      //             onTap: () {
      //               Navigator.pushNamed(context, shopDetailsRoute,
      //                   arguments: shop.id);
      //             },
      //             child:
      //                 ShopBlock(imageUrl: imageUrl, name: name, rating: rating),
      //           ));
      //     }),
    );
  }
}
