import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/widgets/product_block.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/popular_products/remote_popular_products_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularProductsList extends StatelessWidget {
  const PopularProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemotePopularProductsBloc, RemotePopularProductsState>(
        builder: (context, state) {
      if (state is RemotePopularProductsLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RemotePopularProductsError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is RemotePopularProductsLoaded) {
        return productsListBlock(state);
      }
      return const SizedBox();
    });
  }

  Widget productsListBlock(RemotePopularProductsLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('Popular',
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
                    child: ProductBlock(
                      imageUrl: imageUrl,
                      name: name,
                      price: price,
                    ));
                // child: productBlock(imageUrl, name, price));
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
}
