import 'package:coffee_start/core/utils/formatters.dart';
import 'package:coffee_start/core/widgets/cart_product_list.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  final OrderEntity order;

  const OrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd.MM.yyyy – kk:mm').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Number: ${order.id}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Order Date: $formattedDate',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Total Price: ${order.totalPrice} TMT',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Status: ${getOrderStatus(order.status)}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Order Items:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
                child: CartProductList(
              products: order.products,
            )),
          ],
        ),
      ),
    );
  }
}
