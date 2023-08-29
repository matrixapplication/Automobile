import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/description_model.dart';
import 'package:automobile_project/data/models/slider/slider_model.dart';
import 'package:automobile_project/domain/use_case/general/sliders_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class StaticPagViewModel extends ChangeNotifier{
  final SlidersUseCase _showSlidersUseCase;


  StaticPagViewModel({required SlidersUseCase showSlidersUseCase,
  })
      : _showSlidersUseCase = showSlidersUseCase;


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<DiscriptionModel>? _showDescResponse;

  ResponseModel<DiscriptionModel>? get showDescResponse {
    return _showDescResponse;
  }
  ResponseModel<DiscriptionModel>? _showPrivicyResponse;

  ResponseModel<DiscriptionModel>? get showPrivicyResponse {
    return _showPrivicyResponse;
  }
  ResponseModel<DiscriptionModel>? _showReturnCarResponse;

  ResponseModel<DiscriptionModel>? get showReturnCarResponse {
    return _showReturnCarResponse;
  }

  Future<ResponseModel<DiscriptionModel>> terms({
    required BuildContext context,

  }) async {
    _isLoading = true;
    final responseModel = await _showSlidersUseCase.terms(
      context: context,
    );
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      ResponseModel<DiscriptionModel>? data = responseModel;
      _showDescResponse = data ;
      if (kDebugMode) {
        print("success view Model data ${responseModel.data}");
      }
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel<DiscriptionModel>> privacy({
    required BuildContext context,

  }) async {
    _isLoading = true;
    final responseModel = await _showSlidersUseCase.privacy(
      context: context,
    );
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      ResponseModel<DiscriptionModel>? data = responseModel;
      _showPrivicyResponse = data ;
      if (kDebugMode) {
        print("success view Model data ${responseModel.data}");
      }
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel<DiscriptionModel>> returnCar({
    required BuildContext context,

  }) async {
    _isLoading = true;
    final responseModel = await _showSlidersUseCase.carReturnCall(
      context: context,
    );
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      ResponseModel<DiscriptionModel>? data = responseModel;
      _showReturnCarResponse = data ;
      if (kDebugMode) {
        print("success view Model data ${responseModel.data}");
      }
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}