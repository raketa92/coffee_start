import 'package:coffee_start/features/card/presentation/pages/cards_list.dart';
import 'package:coffee_start/features/cart/presentation/pages/cart_items_list.dart';
import 'package:coffee_start/features/home/main_layout.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/presentation/pages/checkout_state/checkout_stepper_state.dart';
import 'package:coffee_start/features/orders/presentation/pages/order_details.dart';
import 'package:coffee_start/features/orders/presentation/pages/orders_list.dart';
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
        final String categoryGuid = arguments['categoryGuid'];
        final String categoryName = arguments['categoryName'];
        return _materialRoute(ProductsByCategory(
          categoryGuid: categoryGuid,
          categoryName: categoryName,
        ));

      case productDetailsRoute:
        final String productId = settings.arguments as String;
        return _materialRoute(ProductDetails(productGuid: productId));

      case shopsRoute:
        return _materialRoute(const ShopsList());

      case shopDetailsRoute:
        final String shopGuid = settings.arguments as String;
        return _materialRoute(ShopDetails(shopGuid: shopGuid));

      case favouritesRoute:
        return _materialRoute(const LikedProductsList());

      case ordersRoute:
        return _materialRoute(const OrdersList());

      case orderDetails:
        final OrderEntity order = settings.arguments as OrderEntity;
        return _materialRoute(OrderDetails(order: order));

      case cartRoute:
        return _materialRoute(const CartItemsList());

      case checkoutRoute:
        final String shopGuid = settings.arguments as String;
        return _materialRoute(CheckoutStepperState(shopGuid: shopGuid));

      case cardsRoute:
        return _materialRoute(const CardsList());

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
