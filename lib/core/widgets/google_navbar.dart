import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleBottomNavigation extends StatefulWidget {
  const GoogleBottomNavigation({super.key});

  @override
  State<GoogleBottomNavigation> createState() => _GoogleBottomNavigationState();
}

class _GoogleBottomNavigationState extends State<GoogleBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 16, top: 4),
      child: const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        child: GNav(
          iconSize: 24,
          tabBackgroundColor: Colors.white70,
          backgroundColor: Colors.amber,
          color: Colors.white,
          activeColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          tabMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          curve: Curves.linear,
          tabs: [
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
              icon: Icons.receipt_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
