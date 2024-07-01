import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/constants/routes.dart';
import 'package:coffee_start/core/widgets/google_navbar.dart';
import 'package:coffee_start/core/widgets/shop_block.dart';
import 'package:coffee_start/features/shops/presentation/bloc/remote/shops/remote_shops_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopsList extends StatefulWidget {
  const ShopsList({super.key});

  @override
  State<ShopsList> createState() => _ShopsListState();
}

class _ShopsListState extends State<ShopsList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RemoteShopsBloc>()..add(const GetShops()),
      child: BlocBuilder<RemoteShopsBloc, RemoteShopsState>(
          builder: (context, state) {
        if (state is RemoteShopsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteShopsError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (state is RemoteShopsLoaded) {
          return shopsListView(state);
        }

        return Container();
      }),
    );
  }

  Widget shopsListView(RemoteShopsLoaded state) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(state),
      bottomNavigationBar: const GoogleBottomNavigation(),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text('Shops', style: TextStyle(fontSize: 18)),
    );
  }

  _body(RemoteShopsLoaded state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 3 / 4),
          itemCount: state.shops.length,
          itemBuilder: (context, index) {
            final shop = state.shops[index];
            final image = shop.image;
            final imageUrl = '$apiBaseUrl/$image';
            final name = shop.name;
            final rating = shop.rating;
            return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, shopDetailsRoute,
                        arguments: shop.id);
                  },
                  child:
                      ShopBlock(imageUrl: imageUrl, name: name, rating: rating),
                ));
          }),
    );
  }
}
