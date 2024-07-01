import 'package:coffee_start/features/categories/data/datasources/remote/categories_api_service.dart';
import 'package:coffee_start/features/categories/data/repository/category_repository_impl.dart';
import 'package:coffee_start/features/categories/domain/repository/category_repository.dart';
import 'package:coffee_start/features/categories/domain/usecases/get_categories.dart';
import 'package:coffee_start/features/categories/presentation/remote/bloc/remote_category_bloc.dart';
import 'package:coffee_start/features/products/data/datasource/remote/products_api_service.dart';
import 'package:coffee_start/features/products/data/repository/product_repository_impl.dart';
import 'package:coffee_start/features/products/domain/repository/product_repository.dart';
import 'package:coffee_start/features/products/domain/usecases/get_new_products.dart';
import 'package:coffee_start/features/products/domain/usecases/get_popular_products.dart';
import 'package:coffee_start/features/products/domain/usecases/get_product.dart';
import 'package:coffee_start/features/products/domain/usecases/get_products.dart';
import 'package:coffee_start/features/products/domain/usecases/get_products_by_category.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/new_products/remote_new_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/popular_products/remote_popular_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/product_details/remote_product_details_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/products_by_category/remote_products_by_category_bloc.dart';
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

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<CategoriesApiService>(CategoriesApiService(sl()));
  sl.registerSingleton<ProductsApiService>(ProductsApiService(sl()));
  sl.registerSingleton<ShopsApiService>(ShopsApiService(sl()));

  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  sl.registerSingleton<ShopRepository>(ShopRepositoryImpl());

  sl.registerFactory<RemoteCategoryBloc>(() => RemoteCategoryBloc(sl()));
  sl.registerFactory<RemoteProductBloc>(() => RemoteProductBloc(sl()));
  sl.registerFactory<RemotePopularProductsBloc>(
      () => RemotePopularProductsBloc(sl()));
  sl.registerFactory<RemoteNewProductsBloc>(() => RemoteNewProductsBloc(sl()));
  sl.registerFactory<RemoteProductsByCategoryBloc>(
      () => RemoteProductsByCategoryBloc(sl()));
  sl.registerFactory<RemoteProductDetailsBloc>(
      () => RemoteProductDetailsBloc(sl()));
  sl.registerFactory<RemoteShopsBloc>(() => RemoteShopsBloc(sl()));
  sl.registerFactory<RemoteShopDetailsBloc>(() => RemoteShopDetailsBloc(sl()));

  sl.registerSingleton<GetCategoriesUseCase>(GetCategoriesUseCase(sl()));
  sl.registerSingleton<GetProductsUseCase>(GetProductsUseCase(sl()));
  sl.registerSingleton<GetNewProductsUseCase>(GetNewProductsUseCase(sl()));
  sl.registerSingleton<GetPopularProductsUseCase>(
      GetPopularProductsUseCase(sl()));
  sl.registerSingleton<GetProductsByCategoryUseCase>(
      GetProductsByCategoryUseCase(sl()));
  sl.registerSingleton<GetProductUseCase>(GetProductUseCase(sl()));
  sl.registerSingleton<GetShopsUseCase>(GetShopsUseCase(sl()));
  sl.registerSingleton<GetShopDetailsUseCase>(GetShopDetailsUseCase(sl()));
}
