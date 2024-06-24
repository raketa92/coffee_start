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
import 'package:coffee_start/features/products/domain/usecases/get_products.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/new_products/remote_new_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/popular_products/remote_popular_products_bloc.dart';
import 'package:coffee_start/features/products/presentation/bloc/remote/remote_product_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<CategoriesApiService>(CategoriesApiService(sl()));
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  sl.registerSingleton<GetCategoriesUseCase>(GetCategoriesUseCase(sl()));
  sl.registerFactory<RemoteCategoryBloc>(() => RemoteCategoryBloc(sl()));

  sl.registerSingleton<ProductsApiService>(ProductsApiService(sl()));
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());
  sl.registerSingleton<GetProductsUseCase>(GetProductsUseCase(sl()));
  sl.registerFactory<RemoteProductBloc>(() => RemoteProductBloc(sl()));
  sl.registerFactory<RemotePopularProductsBloc>(
      () => RemotePopularProductsBloc(sl()));
  sl.registerFactory<RemoteNewProductsBloc>(() => RemoteNewProductsBloc(sl()));
  sl.registerSingleton<GetNewProductsUseCase>(GetNewProductsUseCase(sl()));
  sl.registerSingleton<GetPopularProductsUseCase>(
      GetPopularProductsUseCase(sl()));
}
