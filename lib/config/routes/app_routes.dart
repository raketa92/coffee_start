import 'package:coffee_start/features/cart/presentation/pages/cart_items_list.dart';
import 'package:coffee_start/features/home/main_layout.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout_stepper.dart';
import 'package:coffee_start/features/products/presentation/pages/product_details.dart';
import 'package:coffee_start/features/products/presentation/pages/products_by_category.dart';
import 'package:coffee_start/features/products/presentation/pages/products_liked.dart';
import 'package:coffee_start/features/shops/presentation/pages/shop_details.dart';
import 'package:coffee_start/features/shops/presentation/pages/shops_list.dart';
import 'package:flutter/material.dart';

import '../../core/constants/routes.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(const MainLayout());

      case productsByCategoryRoute:
        final arguments = settings.arguments as Map<String, dynamic>;
        final int categoryId = arguments['categoryId'];
        final String categoryName = arguments['categoryName'];
        return _materialRoute(ProductsByCategory(
          categoryId: categoryId,
          categoryName: categoryName,
        ));

      case productDetailsRoute:
        final int productId = settings.arguments as int;
        return _materialRoute(ProductDetails(productId: productId));

      case shopsRoute:
        return _materialRoute(const ShopsList());

      case shopDetailsRoute:
        final int shopId = settings.arguments as int;
        return _materialRoute(ShopDetails(shopId: shopId));

      case favouritesRoute:
        return _materialRoute(const LikedProductsList());

      case ordersRoute:
        return _materialRoute(const Text("orders"));

      case cartRoute:
        return _materialRoute(const CartItemsList());

      case checkoutRoute:
        final int shopId = settings.arguments as int;
        return _materialRoute(CheckoutStepper(shopId: shopId));

      // case orderCompleteRoute:
      //   return _materialRoute(const OrderCompletePage());

      default:
        return _materialRoute(const MainLayout());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
