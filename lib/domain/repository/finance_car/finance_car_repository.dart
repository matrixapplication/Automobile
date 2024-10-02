import 'dart:io';

import 'package:dio/dio.dart';

import '../../../data/models/base_response/api_response.dart';
import '../../entities/add_car_entity/add_car_entity.dart';

mixin FinanceCarRepository {
  Future<ApiResponse> financeCar({
    required Map<String , dynamic> formData
  });
  Future<ApiResponse> financeAddOfferCar({
    required Map<String , dynamic> formData
  });
  Future<ApiResponse> getContactUs();
  Future<ApiResponse> getFinanceCar({
    required int page
  });

}
