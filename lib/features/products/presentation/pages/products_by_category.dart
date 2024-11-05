import 'package:coffee_start/core/constants/routes.dart';
import 'package:coffee_start/core/widgets/product_block.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/products_by_category/remote_products_by_category_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsByCategory extends StatefulWidget {
  final String categoryGuid;
  final String categoryName;
  const ProductsByCategory(
      {super.key, required this.categoryGuid, required this.categoryName});

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RemoteProductsByCategoryBloc>()
        ..add(GetProductsByCategory(widget.categoryGuid)),
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
            final product = state.products[index];
            return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, productDetailsRoute,
                        arguments: product.guid);
                  },
                  child: ProductBlock(product: product),
                ));
          }),
    );
  }
}
