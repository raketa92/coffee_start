import 'dart:async';

import 'package:coffee_start/features/categories/data/datasources/remote/categories_api_service.dart';
import 'package:coffee_start/core/api_response/api_response.dart';
import 'package:coffee_start/features/categories/data/models/category.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

class MockCategoriesApiService implements CategoriesApiService {
  @override
  Future<HttpResponse<ApiResponseList<CategoryModel>>> getCategories() async {
    final List<CategoryModel> categories = [
      const CategoryModel(guid: "1", name: "Hot drinks", iconUrl: "test.png"),
      const CategoryModel(guid: "2", name: "Cold drinks", iconUrl: "test.png"),
    ];

    final response = HttpResponse(
      categories,
      Response(
          data: categories,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/categories')),
    );

    return response.response.data;
  }
}
