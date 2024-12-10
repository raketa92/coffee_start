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
      child: Scaffold(
        appBar: _appBar(),
        body: BlocBuilder<RemoteOrdersBloc, RemoteOrdersState>(
          builder: (context, state) {
            if (state is RemoteOrdersLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is RemoteOrdersError) {
              return _errorView();
            }
            if (state is RemoteOrdersLoaded) {
              final orders = state.orders;
              if (orders.isEmpty) {
                return _emptyOrdersView();
              }
              return ordersListView(orders);
            }
            return const Center(child: Text('Something went wrong.'));
          },
        ),
      ),
    );
  }

  Widget ordersListView(List<OrderEntity> orders) {
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

  _appBar() {
    return AppBar(
      title: const Text(
        'Orders',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _emptyOrdersView() {
    return const Center(
      child: Text(
        'No orders found.',
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  Widget _errorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 50, color: Colors.red),
          const SizedBox(height: 10),
          const Text(
            'An error occurred!',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          TextButton(
            onPressed: () {
              // Trigger reload
              context.read<RemoteOrdersBloc>().add(const GetOrders());
            },
            child: const Text(
              'Retry',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
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
        'Order № ${order.orderNumber}',
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
