part of 'liked_products_local_bloc.dart';

abstract class LikedProductsLocalState extends Equatable {
  const LikedProductsLocalState();

  @override
  List<Object> get props => [];
}

class LikedProductsInitial extends LikedProductsLocalState {}

class LikedProductsLoading extends LikedProductsLocalState {}

class LikedProductsLoaded extends LikedProductsLocalState {
  final List<ProductEntity> likedProducts;
  const LikedProductsLoaded({required this.likedProducts});

  LikedProductsLoaded copyWith({required List<ProductEntity> likedProducts}) =>
      LikedProductsLoaded(likedProducts: likedProducts);

  @override
  List<Object> get props => [likedProducts];
}

class LikedProductsError extends LikedProductsLocalState {
  final String message;
  const LikedProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
