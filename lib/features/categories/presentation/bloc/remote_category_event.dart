part of 'remote_category_bloc.dart';

sealed class RemoteCategoryEvent extends Equatable {
  const RemoteCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends RemoteCategoryEvent {
  const GetCategories();
}
