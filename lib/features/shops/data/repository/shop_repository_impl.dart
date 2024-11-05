import 'dart:io';

import 'package:coffee_start/core/api_service/api_service.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/shops/data/datasource/shops_api_service.dart';
import 'package:coffee_start/features/shops/domain/entities/shop.dart';
import 'package:coffee_start/features/shops/domain/entities/shop_products.dart';
import 'package:coffee_start/features/shops/domain/repository/shop_repository.dart';
import 'package:dio/dio.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopsApiService _shopsApiService;
  ShopRepositoryImpl() : _shopsApiService = ApiServiceFactory.shopApiService;

  @override
  Future<DataState<ShopProductsEntity>> getShop(String shopGuid) async {
    try {
      final httpResponse = await _shopsApiService.getShop(shopGuid);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.result);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ShopEntity>>> getShops() async {
    try {
      final httpResponse = await _shopsApiService.getShops();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.result);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
