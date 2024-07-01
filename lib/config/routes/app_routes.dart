import 'package:coffee_start/features/home/home.dart';
import 'package:coffee_start/features/products/presentation/pages/product_details.dart';
import 'package:coffee_start/features/products/presentation/pages/products_by_category.dart';
import 'package:coffee_start/features/shops/presentation/pages/shop_details.dart';
import 'package:coffee_start/features/shops/presentation/pages/shops_list.dart';
import 'package:flutter/material.dart';

import '../../core/constants/routes.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(const HomePage());

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

      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
