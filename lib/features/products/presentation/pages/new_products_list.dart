import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/new_products/remote_new_products_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewProductsList extends StatelessWidget {
  const NewProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteNewProductsBloc, RemoteNewProductsState>(
        builder: (context, state) {
      if (state is RemoteNewProductsLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RemoteNewProductsError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is RemoteNewProductsLoaded) {
        return productsListBlock(state);
      }
      return const SizedBox();
    });
  }

  Widget productsListBlock(RemoteNewProductsLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('New',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          const SizedBox(height: 20),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final image = state.products[index].image;
                final imageUrl = '$apiBaseUrl/$image';
                final name = state.products[index].name;
                final price = state.products[index].price;
                // final productId = state.products[index].id;
                return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: productBlock(imageUrl, name, price));
                // child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   ProductDetails(productId: productId)));
                //     },
                //     child: productBlock(imageUrl, name, price)));
              },
            ),
          )
        ],
      ),
    );
  }

  productBlock(String imageUrl, String name, double price) {
    return SizedBox(
      width: 160,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: CachedNetworkImage(
              height: 160,
              width: 160,
              imageUrl: imageUrl,
              cacheManager: CustomCacheManager.getInstance(),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 6),
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
                    const Icon(Icons.favorite_border)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '\$ $price',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
