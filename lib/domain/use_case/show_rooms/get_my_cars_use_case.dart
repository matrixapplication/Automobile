import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';

import 'package:automobile_project/domain/repository/show_rooms/show_rooms_repository.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class GetMyCarUseCase {
  final BaseShowRoomsRepository _baseShowRoomBranchesRepository;

  GetMyCarUseCase(this._baseShowRoomBranchesRepository);

  Future<ResponseModel<List<CarModel>>> call({required context,
    required int? id,
    required String? modelRole,
    required String? states,
    required String? brand,
    required String? carModel,
    required String? driveType,
    required String? search,
    required String? fuelType,
    required String? startPrice,
    required String? endPrice,
    required String? startYear,
    required String? endYear,
    required int? page,

  }) async {
    ApiResponse apiResponse =
    await _baseShowRoomBranchesRepository.getMyCarList(
        id: id,
        modelRole: modelRole,
        states: states,
        page: page,
        brand: brand,
        carModel: carModel,
        driveType: driveType,
        search: search,
        fuelType: fuelType,
        startPrice: startPrice,
        endPrice: endPrice,
        startYear: startYear,
        endYear: endYear);
    ResponseModel<List<CarModel>> responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<CarModel> agenciesLIst = [];

        baseModel.data.forEach(
                (object) => agenciesLIst.add(CarModel.fromJson(object)));

        responseModel = ResponseModel<List<CarModel>>(
            true, baseModel.message,
            data: agenciesLIst, pagination: baseModel.pagination);
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


  Future<ResponseModel<List<CarModel>>> callSortBy({required context,

    required String? order,
    required String? status,

    required int? page,

  }) async {
    ApiResponse apiResponse =
    await _baseShowRoomBranchesRepository.sortCars(order: order, status: status);
    ResponseModel<List<CarModel>> responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<CarModel> agenciesLIst = [];

        baseModel.data.forEach(
                (object) => agenciesLIst.add(CarModel.fromJson(object)));

        responseModel = ResponseModel<List<CarModel>>(
            true, baseModel.message,
            data: agenciesLIst, pagination: baseModel.pagination);
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
