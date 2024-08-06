

import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';

import 'package:automobile_project/domain/repository/show_rooms/show_rooms_repository.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class ShowRoomsBranchesUseCase {
  final BaseShowRoomsRepository _baseShowRoomBranchesRepository;

  ShowRoomsBranchesUseCase(this._baseShowRoomBranchesRepository);

  Future<ResponseModel<List<ShowRoomBranchModel>>> call({
    required context,
    required int id,
  }) async {
    ApiResponse apiResponse = await _baseShowRoomBranchesRepository
        .showRoomsBranches(id: id);
    ResponseModel<List<ShowRoomBranchModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<ShowRoomBranchModel> responseData = [];

        baseModel.data.forEach(
            (object) => responseData.add(ShowRoomBranchModel.fromJson(object)));

        responseModel = ResponseModel<List<ShowRoomBranchModel>>(
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




  Future<ResponseModel<ShowRoomBranchModel>> add({
    required context,
    required Map<String, dynamic> formData,
  }) async {
    ApiResponse apiResponse = await _baseShowRoomBranchesRepository
        .addBranch(formData: formData);

    ResponseModel<ShowRoomBranchModel> responseModel;


    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (kDebugMode) {
        print(baseModel.data);
      }
      if (baseModel.status == true) {

        ShowRoomBranchModel branchData = ShowRoomBranchModel.fromJson(baseModel.data);
        responseModel = ResponseModel<ShowRoomBranchModel>(
            true, baseModel.message,
            data: branchData);
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



  Future<ResponseModel<List<ShowRoomBranchModel>>> callById({
    required context,
    required int id,
  }) async {
    ApiResponse apiResponse = await _baseShowRoomBranchesRepository
        .showRoomsBranchesById(id: id);
    ResponseModel<List<ShowRoomBranchModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
        print(baseModel.data);
      if (baseModel.status == true) {
        List<ShowRoomBranchModel> responseData = [];

        baseModel.data.forEach(
                (object) => responseData.add(ShowRoomBranchModel.fromJson(object)));

        responseModel = ResponseModel<List<ShowRoomBranchModel>>(
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

  Future<ResponseModel<ShowRoomBranchModel>> edit({
    required context,
    required Map<String, dynamic> formData,
    required int id ,
  }) async {
    ApiResponse apiResponse = await _baseShowRoomBranchesRepository
        .editBranch(formData: formData, id: id);

    ResponseModel<ShowRoomBranchModel> responseModel;


    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (kDebugMode) {
        print(baseModel.data);
      }
      if (baseModel.status == true) {

        ShowRoomBranchModel branchData = ShowRoomBranchModel.fromJson(baseModel.data);
        responseModel = ResponseModel<ShowRoomBranchModel>(
            true, baseModel.message,
            data: branchData);
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
  Future<ResponseModel<ShowRoomBranchModel>> hide({
    required context,
    required int id ,
  }) async {
    ApiResponse apiResponse = await _baseShowRoomBranchesRepository
        .hideBranch( id: id);

    ResponseModel<ShowRoomBranchModel> responseModel;


    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (kDebugMode) {
        print(baseModel.data);
      }
      if (baseModel.status == true) {

        responseModel = ResponseModel<ShowRoomBranchModel>(
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
