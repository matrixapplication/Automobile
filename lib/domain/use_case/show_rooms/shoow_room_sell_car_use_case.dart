import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';
import '../../../data/models/auth_model/auth_model.dart';
import '../../entities/add_car_entity/add_car_entity.dart';
import '../../repository/show_rooms/show_rooms_repository.dart';

class ShowRoomsSellCarUseCase {
  final BaseShowRoomsRepository _baseShowRoomsRepository;

  ShowRoomsSellCarUseCase(this._baseShowRoomsRepository);

  Future<ResponseModel> call({
    required SellCarEntity carEntity,
    required List<File?> images,
    required File mainImage,
    required context,
  }) async {
    ApiResponse apiResponse =
        await _baseShowRoomsRepository.showRoomsAddCar(carData: carEntity,images:images,mainImage:mainImage);
    ResponseModel responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        responseModel = ResponseModel(
          true,
          baseModel.message,
        );
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

  Future<ResponseModel> editCarCall({
    required SellCarEntity carEntity,
    required List<File?> images,
    required File? mainImage,
    required int id , 
    required context,
  }) async {
    ApiResponse apiResponse =
    await _baseShowRoomsRepository.showRoomEditCar(carData: carEntity,images:images,mainImage:mainImage, id: id);
    ResponseModel responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        responseModel = ResponseModel(
          true,
          baseModel.message,
        );
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


  Future<ResponseModel> hide({
    required context,
    required int id ,
  }) async {
    ApiResponse apiResponse = await _baseShowRoomsRepository
        .isBayed( id: id);

    ResponseModel responseModel;


    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (kDebugMode) {
        print(baseModel.data);
      }
      if (baseModel.status == true) {

        responseModel = ResponseModel(
          true, baseModel.message,
        );
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
