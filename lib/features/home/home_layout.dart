import 'package:coffee_start/features/categories/presentation/pages/categories.dart';
import 'package:coffee_start/features/products/presentation/pages/new_products_list.dart';
import 'package:coffee_start/features/products/presentation/pages/popular_products_list.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Categories(
              selectedCategory: _selectedCategory,
            ),
            const PopularProductsList(),
            const NewProductsList(),
          ],
        ),
      ),
    );
  }
}