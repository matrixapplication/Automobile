import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/utils/alerts.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/domain/repository/fav_repository/fav_repository.dart';

import 'package:automobile_project/domain/repository/show_rooms/show_rooms_repository.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class FavUseCase {
  final FavRepository _faveRepository;

  FavUseCase(this._faveRepository);

  Future<ResponseModel<BasicModel>?> call({
    required context,
    required int carId ,
  }) async {
    ApiResponse apiResponse = await _faveRepository
        .addRemoveFav(carId: carId);
    print(apiResponse.response?.data);
    ResponseModel<BasicModel>? responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        BasicModel? responseData;

        responseData = BasicModel.fromJson(responseData as Map<String, dynamic>?) ;


        responseModel = ResponseModel<BasicModel>(true, baseModel.message,
            data: responseData);
      }
      //200
      else {
        responseModel =
            ApiChecker.checkApi(context, message: baseModel.message);
      }
    } else {
      print('baseModel.message ');
      ErrorResponse baseModel = ErrorResponse.fromJson(apiResponse.response?.data);
      final message = baseModel.message;
      responseModel = ApiChecker.checkApi(context, message: message);
    }


    return responseModel;
  }



  Future<ResponseModel<List<CarModel>>> showFavCall({
    required context,

  }) async {
    ApiResponse apiResponse = await _faveRepository
        .showFav();
    ResponseModel<List<CarModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<CarModel> responseData = [];

        baseModel.data.forEach(
                (object) => responseData.add(CarModel.fromJson(object)));

        responseModel = ResponseModel<List<CarModel>>(
            true, baseModel.message,
            data: responseData);
      }
      //200
      else {
        responseModel =
            ApiChecker.checkApi(context, message: baseModel.message);
      }
    } else {
      ErrorResponse baseModel =
      ErrorResponse.fromJson(apiResponse.response?.data);
      final message = baseModel.message;
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }

}
