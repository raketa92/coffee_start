// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:coffee_start/features/cart/domain/entities/cart_item.dart';

class CartParams {
  final String shopGuid;
  final CartItemProductEntity product;
  CartParams({
    required this.shopGuid,
    required this.product,
  });
}
