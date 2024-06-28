part of 'remote_products_by_category_bloc.dart';

sealed class RemoteProductsByCategoryEvent extends Equatable {
  const RemoteProductsByCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetProductsByCategory extends RemoteProductsByCategoryEvent {
  final int categoryId;
  const GetProductsByCategory(this.categoryId);
}
