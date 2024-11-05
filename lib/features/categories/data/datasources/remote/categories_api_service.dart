import 'package:coffee_start/core/api_response/api_response.dart';
import 'package:coffee_start/features/categories/data/models/category.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_api_service.g.dart';

@RestApi()
abstract class CategoriesApiService {
  factory CategoriesApiService(Dio dio) = _CategoriesApiService;

  @GET('/category')
  Future<HttpResponse<ApiResponseList<CategoryModel>>> getCategories();
}
