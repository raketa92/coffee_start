import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/constants/routes.dart';
import 'package:coffee_start/features/categories/presentation/remote/bloc/remote_category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  final String? selectedCategory;
  const Categories({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteCategoryBloc, RemoteCategoryState>(
        builder: (context, state) {
      if (state is RemoteCategoryLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RemoteCategoryError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is RemoteCategoryLoaded) {
        return categoriesBlock(state);
      }
      return const SizedBox();
    });
  }

  Widget categoriesBlock(RemoteCategoryLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(
          height: 10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Our Category',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: SizedBox(
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  final imageUrl = '$apiBaseUrl/${category.iconUrl}';
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, productsByCategoryRoute,
                          arguments: {
                            'categoryId': category.id,
                            'categoryName': category.name
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            width: 64,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(14)),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                cacheManager: CustomCacheManager.getInstance(),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                              width: 80,
                              padding: const EdgeInsets.only(top: 4),
                              alignment: Alignment.center,
                              child: Text(
                                state.categories[index].name,
                                textAlign: TextAlign.center,
                              ))
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
