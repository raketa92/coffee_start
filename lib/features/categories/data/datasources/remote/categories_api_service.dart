import 'package:coffee_start/features/categories/data/models/category.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_api_service.g.dart';

@RestApi()
abstract class CategoriesApiService {
  factory CategoriesApiService(Dio dio) = _CategoriesApiService;

  @GET('/categories')
  Future<HttpResponse<List<CategoryModel>>> getCategories();
}
