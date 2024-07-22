import 'package:coffee_start/core/constants/routes.dart';
import 'package:coffee_start/features/home/home.dart';
import 'package:coffee_start/features/products/presentation/pages/products_by_category.dart';
import 'package:coffee_start/features/products/presentation/pages/products_liked.dart';
import 'package:coffee_start/features/shops/presentation/pages/shops_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class PersistentBottomNavBar extends StatefulWidget {
  const PersistentBottomNavBar({super.key});

  @override
  State<PersistentBottomNavBar> createState() => _PersistentBottomNavBarState();
}

class _PersistentBottomNavBarState extends State<PersistentBottomNavBar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const ShopsList(),
      const LikedProductsList(),
      const Text("orders"),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.white,
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   // initialRoute: "/",
        //   routes: {
        //     productsByCategoryRoute: (final context) =>
        //         const ProductsByCategory(
        //           categoryId: 1,
        //           categoryName: "categoryName",
        //         ),
        //     // productDetailsRoute: (final context) => const MainScreen3(),
        //   },
        // ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.store_outlined),
        title: ("Shops"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_border_outlined),
        title: ("Favorites"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_basket_outlined),
        title: ("Orders"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarItems(),
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      // stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      // popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Colors.grey.shade900,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style5,
    );
  }
}
