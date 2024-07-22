import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/presentation/bloc/local/liked_products/liked_products_local_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBlock extends StatelessWidget {
  final ProductEntity product;
  const ProductBlock({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final image = product.image;
    final imageUrl = '$apiBaseUrl/$image';
    return SizedBox(
      width: 160,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: CachedNetworkImage(
              height: 160,
              width: 160,
              imageUrl: imageUrl,
              cacheManager: CustomCacheManager.getInstance(),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 6),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    BlocBuilder<LikedProductsLocalBloc,
                        LikedProductsLocalState>(
                      builder: (likedProductContext, state) {
                        final isLiked = state is LikedProductsLoaded &&
                            state.likedProducts.contains(product);
                        return GestureDetector(
                            onTap: () {
                              if (isLiked) {
                                likedProductContext
                                    .read<LikedProductsLocalBloc>()
                                    .add(RemoveLikedProduct(product));
                              } else {
                                likedProductContext
                                    .read<LikedProductsLocalBloc>()
                                    .add(AddLikedProduct(product));
                              }
                            },
                            child: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : null,
                            ));
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '\$ ${product.price}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
