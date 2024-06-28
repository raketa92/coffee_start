import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/widgets/product_block.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/products_by_category/remote_products_by_category_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsByCategory extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const ProductsByCategory(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RemoteProductsByCategoryBloc>()
        ..add(GetProductsByCategory(widget.categoryId)),
      child: BlocBuilder<RemoteProductsByCategoryBloc,
          RemoteProductsByCategoryState>(builder: (context, state) {
        if (state is RemoteProductsByCategoryLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteProductsByCategoryError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (state is RemoteProductsByCategoryLoaded) {
          return productsView(state);
        }

        return Container();
      }),
    );
  }

  Widget productsView(RemoteProductsByCategoryLoaded state) {
    return Scaffold(
      appBar: _appBar(widget.categoryName),
      body: _body(state),
    );
  }

  _appBar(String category) {
    return AppBar(
      title: Text(
        category,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  _body(RemoteProductsByCategoryLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 3 / 4),
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            final image = state.products[index].image;
            final imageUrl = '$apiBaseUrl/$image';
            final name = state.products[index].name;
            final price = state.products[index].price;
            return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ProductBlock(
                  imageUrl: imageUrl,
                  name: name,
                  price: price,
                ));
          }),
    );
  }
}
