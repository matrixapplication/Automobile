import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/exceptions/api_error_handler.dart';
import '../../core/services/network/endpoints.dart';
import '../../domain/repository/agency/agency_repository.dart';
import '../../domain/repository/authentication/authentication_repository.dart';
import '../../domain/repository/show_rooms/show_rooms_repository.dart';
import '../data_sourse/remote/dio/dio_client.dart';
import '../models/base_response/api_response.dart';

class ShowAgencyRepository implements BaseAgencyRepository {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  ShowAgencyRepository(
      {required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> allAgency({
    required int page,
  }) async {
    try {
      final queryParameters = {"page": page, "limit": 15, "order": "desc"};
      final response = await dioClient?.get(EndPoints.getAgencyApi,
          queryParameters: queryParameters);
      print("response.data ${response?.data}");
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
