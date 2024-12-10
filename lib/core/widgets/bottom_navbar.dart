import 'package:flutter/material.dart';

class CoffeeBottomNavBar extends StatelessWidget {
  final ValueChanged<int> onItemTapped;
  final int selectedIndex;
  const CoffeeBottomNavBar(
      {super.key, required this.onItemTapped, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        child: BottomAppBar(
          color: Colors.amber,
          // height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                  icon: Icons.home_outlined,
                  index: 0,
                  isSelected: selectedIndex == 0),
              _buildNavItem(
                  icon: Icons.store_outlined,
                  index: 1,
                  isSelected: selectedIndex == 1),
              _buildNavItem(
                  icon: Icons.favorite_border_outlined,
                  index: 2,
                  isSelected: selectedIndex == 2),
              _buildNavItem(
                  icon: Icons.shopping_basket_outlined,
                  index: 3,
                  isSelected: selectedIndex == 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required bool isSelected,
  }) {
    return Expanded(
      child: IconButton(
        icon: Icon(icon),
        iconSize: 28,
        onPressed: () => onItemTapped(index),
        color: isSelected ? Colors.black : Colors.grey,
        padding: const EdgeInsets.only(top: 12),
        constraints: const BoxConstraints(
          maxHeight: 20,
        ),
      ),
    );
  }
}
