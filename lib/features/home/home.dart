import 'package:coffee_start/core/widgets/google_navbar.dart';
import 'package:coffee_start/features/categories/presentation/remote/bloc/remote_category_bloc.dart';
import 'package:coffee_start/features/home/home_layout.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/new_products/remote_new_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/popular_products/remote_popular_products_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: const GoogleBottomNavigation(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.supervised_user_circle_outlined))
      ],
    );
  }

  _buildDrawer() {
    return Drawer(
      child: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text("Shops"),
          ),
          ListTile(
            leading: Icon(Icons.select_all_outlined),
            title: Text("Categories"),
          ),
          ListTile(
            leading: Icon(Icons.favorite_outline),
            title: Text("Favourites"),
          ),
          ListTile(
            leading: Icon(Icons.payment_outlined),
            title: Text("Cards"),
          ),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text("Addresses"),
          )
        ],
      ),
    );
  }

  _buildBody() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteCategoryBloc>(
          create: (context) =>
              sl<RemoteCategoryBloc>()..add(const GetCategories()),
        ),
        BlocProvider<RemoteNewProductsBloc>(
          create: (context) =>
              sl<RemoteNewProductsBloc>()..add(const GetNewProducts()),
        ),
        BlocProvider<RemotePopularProductsBloc>(
          create: (context) =>
              sl<RemotePopularProductsBloc>()..add(const GetPopularProducts()),
        )
      ],
      child: const HomeLayout(),
    );
  }
}
