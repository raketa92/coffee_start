import 'dart:io';

import 'package:coffee_start/core/api_service/api_service.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/categories/data/datasources/remote/categories_api_service.dart';
import 'package:coffee_start/features/categories/domain/entities/category.dart';
import 'package:coffee_start/features/categories/domain/repository/category_repository.dart';
import 'package:dio/dio.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoriesApiService _categoriesApiService;
  // final MockCategoriesApiService _categoriesApiService;
  CategoryRepositoryImpl()
      : _categoriesApiService = ApiServiceFactory.categoriesApiService;

  @override
  Future<DataState<List<CategoryEntity>>> getCategories() async {
    try {
      final httpResponse = await _categoriesApiService.getCategories();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.result);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
