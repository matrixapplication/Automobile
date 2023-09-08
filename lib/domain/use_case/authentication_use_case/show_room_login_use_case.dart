import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../core/exceptions/api_checker.dart';
import '../../../data/models/auth_model/auth_model.dart';
import '../../../data/models/base_response/api_response.dart';
import '../../../data/models/base_response/base_model.dart';
import '../../../data/models/base_response/error_response.dart';
import '../../../data/models/base_response/response_model.dart';
import '../../repository/authentication/authentication_repository.dart';

class ShowRoomLoginUseCase {
  final BaseAuthenticationRepository baseAuthRepository;

  ShowRoomLoginUseCase(this.baseAuthRepository);

  Future<ResponseModel<ShowRoomModel>> call({
    required context,
    required String? code,
    required String? password,
  }) async {
    ApiResponse apiResponse = await baseAuthRepository.showRoomLogin(
      code: code,
      password: password,
    );
    print(apiResponse);
    ResponseModel<ShowRoomModel> responseModel;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (baseModel.status == true) {
        ShowRoomModel data = ShowRoomModel.fromJson(baseModel.data);
        responseModel = ResponseModel<ShowRoomModel>(true, baseModel.message, data: data);
      }
      //200
      else {
        responseModel = ApiChecker.checkApi(context, message: baseModel.message);
      }
    } else {
      ErrorResponse baseModel = ErrorResponse.fromJson(apiResponse.response?.data);
      final message = baseModel.message;

      if (kDebugMode) {
        print(message);
      }
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }

  Future<ResponseModel<ShowRoomModel>> callShowRoomData({
    required context,
  }) async {
    ApiResponse apiResponse = await baseAuthRepository.getShowRoom();
    print(apiResponse);
    ResponseModel<ShowRoomModel> responseModel;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (baseModel.status == true) {
        ShowRoomModel data = ShowRoomModel.fromJson(baseModel.data);
        responseModel = ResponseModel<ShowRoomModel>(true, baseModel.message, data: data);
      }
      //200
      else {
        responseModel = ApiChecker.checkApi(context, message: baseModel.message);
      }
    } else {
      ErrorResponse baseModel = ErrorResponse.fromJson(apiResponse.response?.data);
      final message = baseModel.message;

      if (kDebugMode) {
        print(message);
      }
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }

  Future<ResponseModel<ShowRoomModel>> editShowRoomCall({required context, required String name, required String showRoomName, required String email, required String phone, required String whatsApp, required String password, required String confirmPassword, required String? coverImage}) async {
    ApiResponse apiResponse = await baseAuthRepository.endShowRoomEditProfile(name: name, showRoomName: showRoomName, confirmPassword: confirmPassword, code: email, password: password, phone: phone, whatsApp: whatsApp, coverImage: coverImage);
    ResponseModel<ShowRoomModel> responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (baseModel.status == true) {
        ShowRoomModel data = ShowRoomModel.fromJson(baseModel.data);
        responseModel = ResponseModel<ShowRoomModel>(true, baseModel.message, data: data);
      }
      //200
      else {
        responseModel = ApiChecker.checkApi(context, message: baseModel.message);
      }
    } else {
      ErrorResponse baseModel = ErrorResponse.fromJson(apiResponse.response?.data);
      final message = baseModel.message;
      if (kDebugMode) {
        print(message);
      }
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }

  Future<ResponseModel<ShowRoomModel>> userImageUpload({
    required context,
    required File image,
  }) async {
    ApiResponse apiResponse = await baseAuthRepository.uploadShowRoomImage(
      image: image,
    );

    ResponseModel<ShowRoomModel> responseModel;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (baseModel.status == true) {
        ShowRoomModel data = ShowRoomModel.fromJson(baseModel.data);
        responseModel = ResponseModel<ShowRoomModel>(true, baseModel.message, data: data);
      }
      //200
      else {
        responseModel = ApiChecker.checkApi(context, message: baseModel.message);
      }
    } else {
      ErrorResponse baseModel = ErrorResponse.fromJson(apiResponse.response?.data);
      final message = baseModel.message;
      if (kDebugMode) {
        print(message);
      }
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }

  Future<bool> deleteAccount({required context}) async {
    ApiResponse apiResponse = await baseAuthRepository.deleteAccount();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      return baseModel.status ?? false;
      //200
    }
    return false;
  }
}
