import 'package:coffee_start/core/constants/routes.dart';
import 'package:coffee_start/core/widgets/bottom_navbar.dart';
import 'package:coffee_start/core/widgets/google_navbar.dart';
import 'package:coffee_start/features/home/home_layout.dart';
import 'package:coffee_start/features/products/presentation/pages/products_liked.dart';
import 'package:coffee_start/features/shops/presentation/pages/shops_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _screens() {
    return [
      const HomeLayout(),
      const ShopsList(),
      const LikedProductsList(),
      const Text("orders"),
    ];
  }

  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
    _onPageChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: _buildBody(),
      bottomNavigationBar: GoogleBottomNavigation(
          onItemTapped: _onItemTapped, selectedIndex: _selectedIndex),
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

  _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                shopsRoute,
              );
            },
            child: const ListTile(
              leading: Icon(Icons.shopping_bag_outlined),
              title: Text("Shops"),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.payment_outlined),
            title: Text("Cards"),
          ),
          const ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text("Addresses"),
          )
        ],
      ),
    );
  }

  _buildBody() {
    return PageView(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      physics: const NeverScrollableScrollPhysics(),
      children: _screens(),
    );
  }
}
