import 'package:coffee_start/features/categories/data/datasources/remote/categories_api_service.dart';
import 'package:coffee_start/features/categories/data/repository/category_repository_impl.dart';
import 'package:coffee_start/features/categories/domain/repository/category_repository.dart';
import 'package:coffee_start/features/categories/domain/usecases/get_categories.dart';
import 'package:coffee_start/features/categories/presentation/bloc/remote_category_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<CategoriesApiService>(CategoriesApiService(sl()));
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  sl.registerSingleton<GetCategoriesUseCase>(GetCategoriesUseCase(sl()));
  sl.registerFactory<RemoteCategoryBloc>(() => RemoteCategoryBloc(sl()));
}
