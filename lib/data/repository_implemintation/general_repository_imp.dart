
import 'package:automobile_project/core/exceptions/api_error_handler.dart';
import 'package:automobile_project/core/services/network/endpoints.dart';
import 'package:automobile_project/data/data_sourse/remote/dio/dio_client.dart';
import 'package:automobile_project/data/models/base_response/api_response.dart';
import 'package:automobile_project/domain/repository/general/general_repositry.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImpGeneralRepository implements GeneralRepository{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  ImpGeneralRepository(
      {required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> showSliders() async{
    try {
      final response = await dioClient?.get(
        EndPoints.slidersApi,
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

  @override
  Future<ApiResponse> sellChangeCar({required Map<String, dynamic> formData})  async {
    FormData data = FormData.fromMap(formData);
    try {
      final response = await dioClient?.post(
        EndPoints.sellChangeCarApi,
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
  Future<ApiResponse> trackUrRequest({required String phone}) async {
    FormData data = FormData.fromMap({
      "phone" : phone
    });
    try {
      final response = await dioClient?.post(
        EndPoints.trackYourRequestApi,
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
  Future<ApiResponse> getCarReturnPolicy() async{
    try {
      final response = await dioClient?.get(
        EndPoints.carReturnPolicyApi,
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

  @override
  Future<ApiResponse> privacy() async {
    try {
      final response = await dioClient?.get(
        EndPoints.privacy,
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

  @override
  Future<ApiResponse> terms() async{
    try {
      final response = await dioClient?.get(
        EndPoints.termsConditionApi,
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

  @override
  Future<ApiResponse> aboutUs() async{
    try {
      final response = await dioClient?.get(
        EndPoints.aboutUs,
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

  @override
  Future<ApiResponse> allNotification({required int page}) async{
    try {
      final response = await dioClient?.get(
        EndPoints.allNotification,
        queryParameters: {"page" : page}
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

