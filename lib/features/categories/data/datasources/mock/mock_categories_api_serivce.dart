import 'dart:async';

import 'package:coffee_start/features/categories/data/datasources/remote/categories_api_service.dart';
import 'package:coffee_start/features/categories/data/models/category.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

class MockCategoriesApiService implements CategoriesApiService {
  @override
  Future<HttpResponse<List<CategoryModel>>> getCategories() async {
    final List<CategoryModel> categories = [
      const CategoryModel(id: 1, name: "Hot drinks", iconUrl: "test.png"),
      const CategoryModel(id: 2, name: "Cold drinks", iconUrl: "test.png"),
    ];

    final response = HttpResponse(
      categories,
      Response(
          data: categories,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/categories')),
    );

    return response;
  }
}
