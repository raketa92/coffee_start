import 'package:coffee_start/core/constants/routes.dart';
import 'package:coffee_start/core/widgets/product_block.dart';
import 'package:coffee_start/features/products/presentation/bloc/local/liked_products/liked_products_local_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedProductsList extends StatefulWidget {
  const LikedProductsList({super.key});

  @override
  State<LikedProductsList> createState() => _LikedProductsListState();
}

class _LikedProductsListState extends State<LikedProductsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedProductsLocalBloc, LikedProductsLocalState>(
        builder: (context, state) {
      if (state is LikedProductsLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is LikedProductsError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is LikedProductsLoaded) {
        return productsView(state);
      }

      return Container();
    });
  }

  Widget productsView(LikedProductsLoaded state) {
    return Scaffold(
      appBar: _appBar("Liked"),
      body: _body(state),
      // bottomNavigationBar: const GoogleBottomNavigation(),
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

  _body(LikedProductsLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 3 / 4),
          itemCount: state.likedProducts.length,
          itemBuilder: (context, index) {
            final product = state.likedProducts[index];
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
