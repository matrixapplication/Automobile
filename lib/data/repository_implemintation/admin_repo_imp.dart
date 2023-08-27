
import 'package:automobile_project/core/exceptions/api_error_handler.dart';
import 'package:automobile_project/core/services/network/endpoints.dart';
import 'package:automobile_project/data/data_sourse/remote/dio/dio_client.dart';
import 'package:automobile_project/data/models/base_response/api_response.dart';
import 'package:automobile_project/domain/repository/admin/admin_repository.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ImpAdminRepo implements AdminRepository{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  ImpAdminRepo(
      {required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> getAdminCars({required int page}) async{
    try {
      final queryParameters = {"page": page, "limit": 7, "order": "desc"};

      final response = await dioClient?.get(
        queryParameters: queryParameters,
        EndPoints.getAdminCars,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }





}