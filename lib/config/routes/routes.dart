import 'package:coffee_start/features/home/home.dart';
import 'package:coffee_start/features/products/presentation/pages/products_by_category.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return _materialRoute(const HomePage());

      case "/products_by_category":
        final arguments = settings.arguments as Map<String, dynamic>;
        final int categoryId = arguments['categoryId'];
        final String categoryName = arguments['categoryName'];
        return _materialRoute(ProductsByCategory(
          categoryId: categoryId,
          categoryName: categoryName,
        ));

      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
