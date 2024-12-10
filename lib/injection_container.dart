import 'package:coffee_start/features/card/data/repository/card_repository_local_impl.dart';
import 'package:coffee_start/features/card/domain/repository/card_repository_local.dart';
import 'package:coffee_start/features/card/domain/usecases/add_card.dart';
import 'package:coffee_start/features/card/domain/usecases/get_cards.dart';
import 'package:coffee_start/features/card/domain/usecases/remove_card.dart';
import 'package:coffee_start/features/card/domain/usecases/update_card.dart';
import 'package:coffee_start/features/card/presentation/bloc/local/card/card_local_bloc.dart';
import 'package:coffee_start/features/cart/data/repository/cart_item_repository_local_impl.dart';
import 'package:coffee_start/features/cart/domain/repository/cart_repository_local.dart';
import 'package:coffee_start/features/cart/domain/usecases/add_to_cart.dart';
import 'package:coffee_start/features/cart/domain/usecases/get_cart_items.dart';
import 'package:coffee_start/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:coffee_start/features/cart/domain/usecases/save_cart_items.dart';
import 'package:coffee_start/features/cart/presentation/bloc/local/cart_items/cart_items_local_bloc.dart';
import 'package:coffee_start/features/categories/data/datasources/remote/categories_api_service.dart';
import 'package:coffee_start/features/categories/data/repository/category_repository_impl.dart';
import 'package:coffee_start/features/categories/domain/repository/category_repository.dart';
import 'package:coffee_start/features/categories/domain/usecases/get_categories.dart';
import 'package:coffee_start/features/categories/presentation/remote/bloc/remote_category_bloc.dart';
import 'package:coffee_start/features/orders/data/datasource/orders_api_service.dart';
import 'package:coffee_start/features/orders/data/repository/orders_repository_impl.dart';
import 'package:coffee_start/features/orders/domain/repository/order_repository.dart';
import 'package:coffee_start/features/orders/domain/usecases/create_order.dart';
import 'package:coffee_start/features/orders/domain/usecases/get_orders.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/checkout/local_checkout_bloc.dart';
import 'package:coffee_start/features/orders/presentation/bloc/remote/orders/remote_orders_bloc.dart';
import 'package:coffee_start/features/products/data/datasource/remote/products_api_service.dart';
import 'package:coffee_start/features/products/data/repository/product_repository_impl.dart';
import 'package:coffee_start/features/products/data/repository/product_repository_local_impl.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository_local.dart';
import 'package:coffee_start/features/products/domain/usecases/add_liked_product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_liked_products.dart';
import 'package:coffee_start/features/products/domain/usecases/get_new_products.dart';
import 'package:coffee_start/features/products/domain/usecases/get_popular_products.dart';
import 'package:coffee_start/features/products/domain/usecases/get_product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_products.dart';
import 'package:coffee_start/features/products/domain/usecases/get_products_by_category.dart';
import 'package:coffee_start/features/products/domain/usecases/get_products_by_shop.dart';
import 'package:coffee_start/features/products/domain/usecases/remove_liked_product.dart';
import 'package:coffee_start/features/products/presentation/bloc/local/liked_products/liked_products_local_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/new_products/remote_new_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/popular_products/remote_popular_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/product_details/remote_product_details_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/products_by_category/remote_products_by_category_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/products_by_shop/remote_products_by_shop_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/remote_product_bloc.dart';
import 'package:coffee_start/features/shops/data/datasource/shops_api_service.dart';
import 'package:coffee_start/features/shops/data/repository/shop_repository_impl.dart';
import 'package:coffee_start/features/shops/domain/repository/shop_repository.dart';
import 'package:coffee_start/features/shops/domain/usecases/get_shop_details.dart';
import 'package:coffee_start/features/shops/domain/usecases/get_shops.dart';
import 'package:coffee_start/features/shops/presentation/bloc/remote/shop_details/remote_shop_details_bloc.dart';
import 'package:coffee_start/features/shops/presentation/bloc/remote/shops/remote_shops_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final storage = HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<CategoriesApiService>(CategoriesApiService(sl()));
  sl.registerSingleton<ProductsApiService>(ProductsApiService(sl()));
  sl.registerSingleton<ShopsApiService>(ShopsApiService(sl()));
  sl.registerSingleton<OrdersApiService>(OrdersApiService(sl()));

  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  sl.registerSingleton<ShopRepository>(ShopRepositoryImpl());
  sl.registerSingleton<ProductRepositoryLocal>(
      ProductRepositoryLocalImpl(storage: storage));
  sl.registerSingleton<CartItemRepositoryLocal>(
      CartItemRepositoryLocalImpl(storage: storage));
  sl.registerSingleton<CardRepositoryLocal>(
      CardRepositoryLocalImpl(storage: storage));
  sl.registerSingleton<OrderRepository>(OrderRepositoryImpl());

  sl.registerFactory<RemoteCategoryBloc>(() => RemoteCategoryBloc(sl()));
  sl.registerFactory<RemoteProductBloc>(() => RemoteProductBloc(sl()));
  sl.registerFactory<RemotePopularProductsBloc>(
      () => RemotePopularProductsBloc(sl()));
  sl.registerFactory<RemoteNewProductsBloc>(() => RemoteNewProductsBloc(sl()));
  sl.registerFactory<RemoteProductsByCategoryBloc>(
      () => RemoteProductsByCategoryBloc(sl()));
  sl.registerFactory<RemoteProductsByShopBloc>(
      () => RemoteProductsByShopBloc(sl()));
  sl.registerFactory<RemoteProductDetailsBloc>(
      () => RemoteProductDetailsBloc(sl()));
  sl.registerFactory<RemoteShopsBloc>(() => RemoteShopsBloc(sl()));
  sl.registerFactory<RemoteShopDetailsBloc>(() => RemoteShopDetailsBloc(sl()));
  sl.registerFactory<LikedProductsLocalBloc>(
      () => LikedProductsLocalBloc(sl(), sl(), sl()));
  sl.registerFactory<CartItemsLocalBloc>(
      () => CartItemsLocalBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<CardLocalBloc>(
      () => CardLocalBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RemoteOrdersBloc>(() => RemoteOrdersBloc(sl(), sl()));
  sl.registerFactory<LocalCheckoutBloc>(() => LocalCheckoutBloc(storage));

  sl.registerSingleton<GetCategoriesUseCase>(GetCategoriesUseCase(sl()));
  sl.registerSingleton<GetProductsUseCase>(GetProductsUseCase(sl()));
  sl.registerSingleton<GetNewProductsUseCase>(GetNewProductsUseCase(sl()));
  sl.registerSingleton<GetPopularProductsUseCase>(
      GetPopularProductsUseCase(sl()));
  sl.registerSingleton<GetProductsByCategoryUseCase>(
      GetProductsByCategoryUseCase(sl()));
  sl.registerSingleton<GetProductsByShopUseCase>(
      GetProductsByShopUseCase(sl()));
  sl.registerSingleton<GetProductUseCase>(GetProductUseCase(sl()));
  sl.registerSingleton<GetShopsUseCase>(GetShopsUseCase(sl()));
  sl.registerSingleton<GetShopDetailsUseCase>(GetShopDetailsUseCase(sl()));
  sl.registerSingleton<AddLikedProductUseCase>(AddLikedProductUseCase(sl()));
  sl.registerSingleton<GetLikedProductsUseCase>(GetLikedProductsUseCase(sl()));
  sl.registerSingleton<RemoveLikedProductUseCase>(
      RemoveLikedProductUseCase(sl()));
  sl.registerSingleton<AddToCartUseCase>(AddToCartUseCase(sl()));
  sl.registerSingleton<GetCartItemsUseCase>(GetCartItemsUseCase(sl()));
  sl.registerSingleton<RemoveFromCartUseCase>(RemoveFromCartUseCase(sl()));
  sl.registerSingleton<SaveCartItemsUseCase>(SaveCartItemsUseCase(sl()));
  sl.registerSingleton<AddCardUseCase>(AddCardUseCase(sl()));
  sl.registerSingleton<UpdateCardUseCase>(UpdateCardUseCase(sl()));
  sl.registerSingleton<RemoveCardUseCase>(RemoveCardUseCase(sl()));
  sl.registerSingleton<GetCardsUseCase>(GetCardsUseCase(sl()));
  sl.registerSingleton<GetOrdersUseCase>(GetOrdersUseCase(sl()));
  sl.registerSingleton<CreateOrdersUseCase>(CreateOrdersUseCase(sl()));
}
