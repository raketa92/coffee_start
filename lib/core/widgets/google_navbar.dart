import 'package:coffee_start/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const GoogleBottomNavigation(
      {super.key, required this.onItemTapped, required this.selectedIndex});

  // void _onTabChange(int index) {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 16, top: 4),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        child: GNav(
          iconSize: 24,
          tabBackgroundColor: Colors.white70,
          backgroundColor: Colors.amber,
          color: Colors.white,
          activeColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          tabMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          curve: Curves.linear,
          onTabChange: onItemTapped,
          selectedIndex: selectedIndex,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
            ),
            GButton(
              icon: Icons.store_outlined,
            ),
            GButton(
              icon: Icons.favorite_border_outlined,
            ),
            GButton(
              icon: Icons.shopping_basket_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
