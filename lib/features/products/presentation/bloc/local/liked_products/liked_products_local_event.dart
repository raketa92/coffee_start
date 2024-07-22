part of 'liked_products_local_bloc.dart';

sealed class LikedProductsLocalEvent extends Equatable {
  const LikedProductsLocalEvent();

  @override
  List<Object> get props => [];
}

class FetchLikedProducts extends LikedProductsLocalEvent {
  const FetchLikedProducts();
}

class AddLikedProduct extends LikedProductsLocalEvent {
  final ProductEntity likedProduct;
  const AddLikedProduct(this.likedProduct);
}

class RemoveLikedProduct extends LikedProductsLocalEvent {
  final ProductEntity likedProduct;
  const RemoveLikedProduct(this.likedProduct);
}
