import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/utils/formatters.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/orders/remote_orders_bloc.dart';
import 'package:coffee_start/features/orders/presentation/pages/order_details.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
            final orders = state.orders;
            if (orders.isEmpty) {
              return const Center(child: Text('No orders found.'));
            }
            return ordersListView(orders);
          }
          return Container();
        },
      ),
    );
  }

  Widget ordersListView(List<OrderEntity> orders) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(orders),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text(
        'Orders',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  _body(List<OrderEntity> orders) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView.separated(
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderListItem(order: order);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  thickness: 2,
                ),
            itemCount: orders.length));
  }
}

class OrderListItem extends StatelessWidget {
  final OrderEntity order;
  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd.MM.yyyy – kk:mm').format(DateTime.now());
    return ListTile(
      leading: Icon(Icons.shopping_bag, color: Colors.blue[700], size: 30),
      title: Text(
        'Order № ${order.id}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total: ${order.totalPrice.toStringAsFixed(2)} TMT (${getOrderStatus(order.status)})',
            style: TextStyle(
              fontSize: 16,
              color: order.status == OrderStatuses.completed
                  ? Colors.green
                  : Colors.grey,
            ),
          ),
          const SizedBox(height: 4), // Add some space
          Text(
            'Date: $formattedDate',
            style: const TextStyle(color: Colors.black54, fontSize: 15),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetails(order: order),
          ),
        );
      },
    );
  }
}
