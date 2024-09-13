import 'package:coffee_start/config/routes/app_routes.dart';
import 'package:coffee_start/config/theme/app_theme.dart';
import 'package:coffee_start/features/card/presentation/bloc/local/card/card_local_bloc.dart';
import 'package:coffee_start/features/cart/presentation/bloc/local/cart_items/cart_items_local_bloc.dart';
import 'package:coffee_start/features/categories/presentation/remote/bloc/remote_category_bloc.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/orders/remote_orders_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/local/liked_products/liked_products_local_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/new_products/remote_new_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/popular_products/remote_popular_products_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
        ),
        BlocProvider<CartItemsLocalBloc>(
          create: (context) =>
              sl<CartItemsLocalBloc>()..add(const GetCartItems()),
        ),
        BlocProvider<CardLocalBloc>(
          create: (context) => sl<CardLocalBloc>()..add(const GetCards()),
        ),
        BlocProvider<RemoteOrdersBloc>(
          create: (context) => sl<RemoteOrdersBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
      ),
    );
  }
}
