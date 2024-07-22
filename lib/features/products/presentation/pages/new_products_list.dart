import 'package:coffee_start/core/widgets/product_list.dart';
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
          ProductList(
            productCount: state.products.length,
            products: state.products,
          )
        ],
      ),
    );
  }
}
