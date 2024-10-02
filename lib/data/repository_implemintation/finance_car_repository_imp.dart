
import 'package:automobile_project/core/exceptions/api_error_handler.dart';
import 'package:automobile_project/core/services/network/endpoints.dart';
import 'package:automobile_project/data/data_sourse/remote/dio/dio_client.dart';
import 'package:automobile_project/data/models/base_response/api_response.dart';
import 'package:automobile_project/domain/repository/general/general_repositry.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/finance_car/finance_car_repository.dart';

class ImpFinanceCarRepository implements FinanceCarRepository{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  ImpFinanceCarRepository(
      {required this.dioClient, required this.sharedPreferences});



  @override
  Future<ApiResponse> financeCar({required Map<String, dynamic> formData})async {
    FormData data = FormData.fromMap(formData);
    try {
      final response = await dioClient?.post(
        EndPoints.financeCars,
        data: data,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }

  @override
  Future<ApiResponse> getContactUs()async {
    try {
      final response = await dioClient?.get(
        EndPoints.getContactUs,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }

  @override
  Future<ApiResponse> getFinanceCar({required int page})async {
    try {
      final response = await dioClient?.get(
        EndPoints.getFinanceCars,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }

  @override
  Future<ApiResponse> financeAddOfferCar({required Map<String, dynamic> formData})async {
    FormData data = FormData.fromMap(formData);
    try {
      final response = await dioClient?.post(
        EndPoints.financeAddOfferCar,
        data: data,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }
  }

