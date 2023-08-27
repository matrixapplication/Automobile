import 'package:automobile_project/core/exceptions/api_error_handler.dart';
import 'package:automobile_project/core/services/network/endpoints.dart';
import 'package:automobile_project/data/data_sourse/remote/dio/dio_client.dart';
import 'package:automobile_project/data/models/base_response/api_response.dart';
import 'package:automobile_project/domain/repository/fav_repository/fav_repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImpFavRepository implements FavRepository{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  ImpFavRepository(
      {required this.dioClient, required this.sharedPreferences});
  @override
  Future<ApiResponse> addRemoveFav({required int carId})  async{

    FormData data = FormData.fromMap({
      "car_id" : carId
    }) ;
    try {
      final response = await dioClient?.post(
        EndPoints.addRemoveFavApi,
        data:  data
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
  Future<ApiResponse> showFav() async {
    try {
      final response = await dioClient?.get(
        EndPoints.showFavApi,
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