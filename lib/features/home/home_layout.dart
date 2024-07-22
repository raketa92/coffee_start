import 'package:coffee_start/features/categories/presentation/pages/categories.dart';
import 'package:coffee_start/features/categories/presentation/remote/bloc/remote_category_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/local/liked_products/liked_products_local_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/new_products/remote_new_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/popular_products/remote_popular_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/pages/new_products_list.dart';
import 'package:coffee_start/features/products/presentation/pages/popular_products_list.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
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
        ),
        BlocProvider<LikedProductsLocalBloc>(
          create: (context) =>
              sl<LikedProductsLocalBloc>()..add(const FetchLikedProducts()),
        )
      ],
      child: _homeBody(),
    );
  }

  Widget _homeBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Categories(
              selectedCategory: _selectedCategory,
            ),
            const PopularProductsList(),
            const NewProductsList(),
          ],
        ),
      ),
    );
  }
}
