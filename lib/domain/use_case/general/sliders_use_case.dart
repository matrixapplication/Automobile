
import 'package:automobile_project/data/models/description_model.dart';
import 'package:automobile_project/data/models/notification/notification.dart';
import 'package:automobile_project/data/models/slider/slider_model.dart';
import 'package:automobile_project/domain/repository/general/general_repositry.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class SlidersUseCase {
  final GeneralRepository _generalRepository;

  SlidersUseCase(this._generalRepository);

  Future<ResponseModel<List<SlidersModel>>> call({
    required context,

  }) async {
    ApiResponse apiResponse = await _generalRepository
        .showSliders();
    ResponseModel<List<SlidersModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<SlidersModel> responseData = [];

        baseModel.data.forEach(
                (object) => responseData.add(SlidersModel.fromJson(object)));

        responseModel = ResponseModel<List<SlidersModel>>(
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



  Future<ResponseModel<DiscriptionModel>> carReturnCall({
    required context,

  }) async {
    ApiResponse apiResponse = await _generalRepository
        .getCarReturnPolicy();
    ResponseModel<DiscriptionModel> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        DiscriptionModel  model  = DiscriptionModel.fromJson(baseModel.data );

        responseModel = ResponseModel(
            true, baseModel.message,
            data: model);
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

  Future<ResponseModel<DiscriptionModel>> terms({
    required context,

  }) async {
    ApiResponse apiResponse = await _generalRepository
        .terms();
    ResponseModel<DiscriptionModel> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        DiscriptionModel  model  = DiscriptionModel.fromJson(baseModel.data) ;

        responseModel = ResponseModel(
            true, baseModel.message,
            data: model);
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


  Future<ResponseModel<DiscriptionModel>> privacy({
    required context,

  }) async {
    ApiResponse apiResponse = await _generalRepository
        .privacy();
    ResponseModel<DiscriptionModel> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        print("Data ==> ${baseModel.data}");
        DiscriptionModel  model  = DiscriptionModel.fromJson(baseModel.data) ;

        responseModel = ResponseModel(
            true, baseModel.message,
            data: model);
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
  Future<ResponseModel<DiscriptionModel>> aboutUs({
    required context,

  }) async {
    ApiResponse apiResponse = await _generalRepository
        .aboutUs();
    ResponseModel<DiscriptionModel> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        print("Data ==> ${baseModel.data}");
        DiscriptionModel  model  = DiscriptionModel.fromJson(baseModel.data) ;

        responseModel = ResponseModel(
            true, baseModel.message,
            data: model);
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
  Future<ResponseModel<List<Notifications>>> allNotification({
    required context,
    required int page
  }) async
  {
    ApiResponse apiResponse = await _generalRepository
        .allNotification(page: page);
    ResponseModel<List<Notifications>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        print("Data ==> ${baseModel.data}");
        List<Notifications>  model   = [];
        baseModel.data.forEach(
                (object) => model.add(Notifications.fromJson(object)));

        responseModel = ResponseModel(
            true, baseModel.message,
            data: model , pagination: baseModel.pagination);
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



  Future<ResponseModel> callSellChangeCar({
    required context,
    required Map<String , dynamic> formData
  }) async {
    ApiResponse apiResponse = await _generalRepository
        .sellChangeCar(formData: formData);
    ResponseModel responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(true, apiResponse.response?.data['message'] ,) ;
    } else {
      responseModel = ResponseModel(true, apiResponse.response?.data['message'],) ;
    }
    return responseModel;
  }

}
