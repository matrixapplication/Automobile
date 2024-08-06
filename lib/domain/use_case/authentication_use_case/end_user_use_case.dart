import 'dart:io';

import 'package:automobile_project/data/models/end_user/end_user_model.dart';
import 'package:automobile_project/domain/logger.dart';
import 'package:flutter/foundation.dart';

import '../../../core/exceptions/api_checker.dart';
import '../../../data/models/base_response/api_response.dart';
import '../../../data/models/base_response/base_model.dart';
import '../../../data/models/base_response/error_response.dart';
import '../../../data/models/base_response/response_model.dart';
import '../../repository/authentication/authentication_repository.dart';

class EndUserLoginUseCase {
  final BaseAuthenticationRepository baseAuthRepository;

  EndUserLoginUseCase(this.baseAuthRepository);

  Future<ResponseModel<EndUserModel>> call({
    required context,
    required String? email,
    required String? password,
  }) async {
    ApiResponse apiResponse = await baseAuthRepository.endUserLogin(
      email: email,
      password: password,
    );
    print(apiResponse);
    ResponseModel<EndUserModel> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (baseModel.status == true) {
        EndUserModel data = EndUserModel.fromJson(baseModel.data);
        responseModel =
            ResponseModel<EndUserModel>(true, baseModel.message, data: data);
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

      if(kDebugMode){
        print(message);
      }
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }



  Future<ResponseModel<EndUserModel>> getEndUser({
    required context,
    required String token ,
  }) async {
    ApiResponse apiResponse = await baseAuthRepository.getEndUser(
      token:  token
    );
    ResponseModel<EndUserModel> responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (baseModel.status == true) {
        EndUserModel data = EndUserModel.fromJson(baseModel.data);
        responseModel =
            ResponseModel<EndUserModel>(true, baseModel.message, data: data);
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
      if(kDebugMode){
        print(message);
      }
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }





  Future<ResponseModel<EndUserModel>> registerCall({
    required context,
    required String name ,
    required String email ,
    required String phone ,
    required String password  ,
    required String confirmPassword ,
    required String countryId ,
  }) async {
    ApiResponse apiResponse = await baseAuthRepository.endUserRegister(
      name: name ,
      image: "" ,
      confirmPassword: confirmPassword ,
      email: email ,
      password: password ,
      phone: phone,
      countryId: countryId
    );
    ResponseModel<EndUserModel> responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (baseModel.status == true) {
        EndUserModel data = EndUserModel.fromJson(baseModel.data);
        responseModel =
            ResponseModel<EndUserModel>(true, baseModel.message, data: data);
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
      if(kDebugMode){
        print('registerCall message $message');
      }
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }



  Future<ResponseModel<EndUserModel>> editEndUserCall({
    required context,
    required String name ,
    required String email ,
    required String phone ,
    required String password  ,
    required String confirmPassword ,
  }) async {
    ApiResponse apiResponse = await baseAuthRepository.endUserEditProfile(
        name: name ,
        confirmPassword: confirmPassword ,
        email: email ,
        password: password ,
        phone: phone
    );
    ResponseModel<EndUserModel> responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (baseModel.status == true) {
        EndUserModel data = EndUserModel.fromJson(baseModel.data);
        responseModel =
            ResponseModel<EndUserModel>(true, baseModel.message, data: data);
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
      if(kDebugMode){
        print(message);
      }
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }


  Future<ResponseModel<EndUserModel>> userImageUpload({
    required context,
    required File image ,
  }) async {
    ApiResponse apiResponse = await baseAuthRepository.uploadImage(
        image: image ,
    );


    ResponseModel<EndUserModel> responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
      if (baseModel.status == true) {
        EndUserModel data = EndUserModel.fromJson(baseModel.data);
        responseModel =
            ResponseModel<EndUserModel>(true, baseModel.message, data: data);
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
      if(kDebugMode){
        print(message);
      }
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }
}
