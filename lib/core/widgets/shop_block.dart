import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:flutter/material.dart';

class ShopBlock extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double rating;
  const ShopBlock(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.rating});

  @override
  Widget build(BuildContext context) {
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
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Icon(Icons.favorite_border)
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.star_outline_outlined),
                    Text(
                      '4.8 (56 reviews)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
