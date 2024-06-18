import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/core/usecases/usecase.dart';
import 'package:coffee_start/features/categories/domain/entities/category.dart';
import 'package:coffee_start/features/categories/domain/repository/category_repository.dart';

class GetCategoriesUseCase
    implements UseCase<DataState<List<CategoryEntity>>, void> {
  final CategoryRepository _categoryRepository;

  GetCategoriesUseCase(this._categoryRepository);

  @override
  Future<DataState<List<CategoryEntity>>> call({void params}) {
    return _categoryRepository.getCategories();
  }
}
