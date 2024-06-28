import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/widgets/product_block.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:flutter/widgets.dart';

class ProductList extends StatelessWidget {
  final int productCount;
  final List<ProductEntity> products;
  const ProductList(
      {super.key, required this.productCount, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productCount,
        itemBuilder: (context, index) {
          final product = products[index];
          final image = product.image;
          final imageUrl = '$apiBaseUrl/$image';
          final name = product.name;
          final price = product.price;
          return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/product_details',
                      arguments: product.id);
                },
                child: ProductBlock(
                  imageUrl: imageUrl,
                  name: name,
                  price: price,
                ),
              ));
        },
      ),
    );
  }
}
