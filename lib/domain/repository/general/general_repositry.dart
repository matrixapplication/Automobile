import 'dart:io';

import 'package:dio/dio.dart';

import '../../../data/models/base_response/api_response.dart';
import '../../entities/add_car_entity/add_car_entity.dart';

mixin GeneralRepository {
  Future<ApiResponse> showSliders();
  Future<ApiResponse> getCarReturnPolicy();
  Future<ApiResponse> privacy();
  Future<ApiResponse> terms();
  Future<ApiResponse> aboutUs();
  Future<ApiResponse> allNotification({required int page});
  Future<ApiResponse> sellChangeCar({
  required Map<String , dynamic> formData
});

  Future<ApiResponse> trackUrRequest({
    required String phone
  });

}
