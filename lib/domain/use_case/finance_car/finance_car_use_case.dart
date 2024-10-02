
import 'package:automobile_project/data/models/description_model.dart';
import 'package:automobile_project/data/models/notification/notification.dart';
import 'package:automobile_project/data/models/slider/slider_model.dart';
import 'package:automobile_project/domain/repository/general/general_repositry.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/exceptions/api_checker.dart';
import '../../../../../data/models/base_response/api_response.dart';
import '../../../../../data/models/base_response/base_model.dart';
import '../../../../../data/models/base_response/error_response.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../data/models/finance_car_model.dart';
import '../../repository/finance_car/finance_car_repository.dart';

class FinanceCarUseCase {
  final FinanceCarRepository _financeCarRepository;

  FinanceCarUseCase(this._financeCarRepository);

  Future<ResponseModel> financeCar({
    required context,
    required Map<String, dynamic> formData}) async
  {
    ApiResponse apiResponse = await _financeCarRepository
        .financeCar(formData: formData);
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {

        responseModel = ResponseModel(
            true, baseModel.message,
            data: baseModel.data);
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

  Future<ResponseModel> financeAddOfferCar({
    required context,
    required Map<String, dynamic> formData}) async
  {
    ApiResponse apiResponse = await _financeCarRepository
        .financeAddOfferCar(formData: formData);
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {

        responseModel = ResponseModel(
            true, baseModel.message,
            data: baseModel.data);
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

  Future<ResponseModel> getContactUs({
    required context
  }) async
  {
    ApiResponse apiResponse = await _financeCarRepository
       .getContactUs();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {

        responseModel = ResponseModel(
            true, baseModel.message,
            data: baseModel.data);

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



  Future<ResponseModel<List<FinanceCarModel>>> getFinanceCar({
    required context,
    required int page
  }) async
  {
    ApiResponse apiResponse = await _financeCarRepository
        .getFinanceCar(page: page);
    ResponseModel<List<FinanceCarModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        print("Data ==> ${baseModel.data}");
        List<FinanceCarModel>  model   = [];
        baseModel.data.forEach(
                (object) => model.add(FinanceCarModel.fromMap(object)));

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



}

