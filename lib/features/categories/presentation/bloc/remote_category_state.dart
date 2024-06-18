part of 'remote_category_bloc.dart';

sealed class RemoteCategoryState extends Equatable {
  const RemoteCategoryState();

  @override
  List<Object> get props => [];
}

final class RemoteCategoryInitial extends RemoteCategoryState {}

final class RemoteCategoryLoading extends RemoteCategoryState {}

final class RemoteCategoryLoaded extends RemoteCategoryState {
  final List<CategoryEntity> categories;

  const RemoteCategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

final class RemoteCategoryError extends RemoteCategoryState {
  final DioException error;

  const RemoteCategoryError(this.error);

  @override
  List<Object> get props => [error];
}
