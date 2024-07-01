import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/shops/domain/entities/shop.dart';
import 'package:coffee_start/features/shops/domain/entities/shop_products.dart';

abstract class ShopRepository {
  Future<DataState<List<ShopEntity>>> getShops();
  Future<DataState<ShopProductsEntity>> getShop(int shopId);
}
