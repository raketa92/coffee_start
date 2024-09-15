import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  final OrderEntity order;

  const OrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Text('Order № ${order.id}'),
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
            Text('Total Price: \$${order.totalPrice}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Status: ${order.id}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Order Items:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                          height: 6,
                        ),
                    shrinkWrap: true,
                    itemCount: order.products.length,
                    itemBuilder: (context, index) {
                      final productName = order.products[index].product.name;
                      final image = order.products[index].product.image;
                      final imageUrl = '$apiBaseUrl/$image';
                      final quantity = order.products[index].quantity;
                      final price = order.products[index].product.price;
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
                    })),
          ],
        ),
      ),

      // Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child:
      // Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text('Order Number: ${order.id}',
      //           style:
      //               const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //       const SizedBox(height: 10),
      //       Text('Order Date: ${DateTime.now()}',
      //           style: const TextStyle(fontSize: 16)),
      //       const SizedBox(height: 10),
      //       Text('Total Price: \$${order.totalPrice}',
      //           style: const TextStyle(fontSize: 16)),
      //       const SizedBox(height: 10),
      //       Text('Status: ${order.id}', style: const TextStyle(fontSize: 16)),
      //       const SizedBox(height: 20),
      //       const Text('Order Items:',
      //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //       const SizedBox(height: 10),
      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: order.products.length,
      //           itemBuilder: (context, index) {
      //             final item = order.products[index];
      //             return ListTile(
      //               title: Text(item.product.name),
      //               subtitle: Text(
      //                   'Quantity: ${item.quantity}, Price: \$${item.product.price.toStringAsFixed(2)}'),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
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
