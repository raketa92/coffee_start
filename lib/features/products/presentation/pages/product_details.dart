import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
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
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          onPressed: () {},
          child: const Center(
            child: Text(
              'Add to Cart',
              style: TextStyle(color: Colors.white),
            ),
          ),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.star_outline_outlined),
                      Icon(Icons.star_outline_outlined),
                      Icon(Icons.star_outline_outlined),
                      Icon(Icons.star_outline_outlined),
                      Icon(Icons.star_outline_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '4.8 (56 reviews)',
                        style: TextStyle(
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
}
