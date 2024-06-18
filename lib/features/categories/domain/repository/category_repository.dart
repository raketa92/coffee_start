import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/categories/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<DataState<List<CategoryEntity>>> getCategories();
}
