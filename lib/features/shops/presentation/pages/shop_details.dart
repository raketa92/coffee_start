import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_start/core/cache/custom_cache_manager.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/core/constants/routes.dart';
import 'package:coffee_start/core/widgets/product_block.dart';
import 'package:coffee_start/features/products/domain/entities/product.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/products_by_shop/remote_products_by_shop_bloc.dart';
import 'package:coffee_start/features/shops/presentation/bloc/remote/shop_details/remote_shop_details_bloc.dart';
import 'package:coffee_start/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopDetails extends StatefulWidget {
  final String shopGuid;
  const ShopDetails({super.key, required this.shopGuid});

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<RemoteShopDetailsBloc>()..add(GetShopDetails(widget.shopGuid)),
        ),
        BlocProvider(
          create: (context) => sl<RemoteProductsByShopBloc>()
            ..add(GetProductsByShop(widget.shopGuid)),
        ),
      ],
      child: BlocBuilder<RemoteShopDetailsBloc, RemoteShopDetailsState>(
          builder: (context, shopState) {
        if (shopState is RemoteShopDetailsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (shopState is RemoteShopDetailsError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (shopState is RemoteShopDetailsLoaded) {
          return BlocBuilder<RemoteProductsByShopBloc,
              RemoteProductsByShopState>(builder: (context, productState) {
            if (productState is RemoteProductsByShopLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (productState is RemoteProductsByShopError) {
              return const Center(child: Icon(Icons.error));
            }
            if (productState is RemoteProductsByShopLoaded) {
              return shopsListView(shopState, productState.products);
            }
            return Container();
          });
        }

        return Container();
      }),
    );
  }

  Widget shopsListView(
      RemoteShopDetailsLoaded state, List<ProductEntity> products) {
    return Scaffold(
      appBar: _appBar(state.shop.name),
      body: _body(state, products),
      // bottomNavigationBar: const GoogleBottomNavigation(),
    );
  }

  _appBar(String shopName) {
    return AppBar(
      title: Text(shopName, style: const TextStyle(fontSize: 18)),
    );
  }

  _body(RemoteShopDetailsLoaded state, List<ProductEntity> products) {
    final shop = state.shop;
    final image = shop.image;
    final imageUrl = '$shopImageUrl/$image';
    final rating = shop.rating;
    return Column(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: CachedNetworkImage(
                height: 200,
                width: 360,
                imageUrl: imageUrl,
                cacheManager: CustomCacheManager.getInstance(),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.star_outline_outlined),
                  Text(
                    '$rating (56 reviews)',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 3 / 4),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, productDetailsRoute,
                              arguments: product.guid);
                        },
                        child: ProductBlock(product: product),
                      ));
                }),
          ),
        ),
      ],
    );
  }
}
