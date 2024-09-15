import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';
import 'package:flutter/material.dart';

class CartProductList extends StatelessWidget {
  final List<CartItemProductEntity> products;
  const CartProductList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 6,
            ),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final productName = products[index].product.name;
          final image = products[index].product.image;
          final imageUrl = '$apiBaseUrl/$image';
          final quantity = products[index].quantity;
          final price = products[index].product.price;
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
