import 'package:coffee_start/core/api_service/network_interceptors.dart';
import 'package:coffee_start/core/constants/constants.dart';
import 'package:coffee_start/features/categories/data/datasources/mock/mock_categories_api_serivce.dart';
import 'package:coffee_start/features/categories/data/datasources/remote/categories_api_service.dart';
import 'package:dio/dio.dart';

class ApiServiceFactory {
  static final Dio _dio = Dio()
    ..options.baseUrl = apiBaseUrl
    ..interceptors.add(NetworkInterceptors())
    ..interceptors.add(LogInterceptor(responseBody: true));

  static final CategoriesApiService categoriesApiService =
      CategoriesApiService(_dio);
  // static final MockCategoriesApiService categoriesApiService =
  //     MockCategoriesApiService();
}
