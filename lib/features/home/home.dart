import 'package:coffee_start/features/categories/presentation/pages/categories.dart';
import 'package:coffee_start/features/products/presentation/pages/new_products_list.dart';
import 'package:coffee_start/features/products/presentation/pages/popular_products_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return _homeBody();
  }

  Widget _homeBody() {
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
