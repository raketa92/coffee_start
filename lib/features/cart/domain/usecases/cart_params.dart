// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';

class CartParams {
  final int shopId;
  final CartItemProductEntity product;
  CartParams({
    required this.shopId,
    required this.product,
  });
}
