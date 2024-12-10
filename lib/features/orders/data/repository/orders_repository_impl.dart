import 'dart:io';

import 'package:coffee_start/core/api_service/api_service.dart';
import 'package:coffee_start/core/resources/data_state.dart';
import 'package:coffee_start/features/orders/data/datasource/dto/create_order_dto.dart';
import 'package:coffee_start/features/orders/data/datasource/orders_api_service.dart';
import 'package:coffee_start/features/orders/domain/entities/order.dart';
import 'package:coffee_start/features/orders/domain/repository/order_repository.dart';
import 'package:dio/dio.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrdersApiService _ordersApiService;
  // final MockOrdersApiService _ordersApiService;
  OrderRepositoryImpl()
      : _ordersApiService = ApiServiceFactory.ordersApiService;

  @override
  Future<DataState<List<OrderEntity>>> getOrders() async {
    try {
      final httpResponse = await _ordersApiService.getOrders();
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
  Future<DataState<CreateOrderResponseDto>> createOrder(
      CreateOrderDto createOrderDto) async {
    try {
      final httpResponse = await _ordersApiService.createOrder(createOrderDto);
      if (httpResponse.response.statusCode == HttpStatus.created) {
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
