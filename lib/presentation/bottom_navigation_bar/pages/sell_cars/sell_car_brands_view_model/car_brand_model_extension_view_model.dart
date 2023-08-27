import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/domain/use_case/drop_down/brand_model_extensions_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';

class CarBrandsModelExtensionViewModel extends ChangeNotifier {
  final CarBrandsModelExtensionUseCase _carBrandsModelExtensionUseCase;

  CarBrandsModelExtensionViewModel({
    required CarBrandsModelExtensionUseCase carBrandsModelExtensionUseCase,
  }) : _carBrandsModelExtensionUseCase = carBrandsModelExtensionUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<BasicModel>>? _getCarBrandsModelExtensionUseCaseResponse;

  ResponseModel<List<BasicModel>>? get getCarBrandsModelExtensionResponse {
    return _getCarBrandsModelExtensionUseCaseResponse;
  }

  clearData(){
    _getCarBrandsModelExtensionUseCaseResponse = null ;
    notifyListeners();
  }


  Future<ResponseModel<List<BasicModel>?>?> getBrandsModels({
    required BuildContext context,
    required int id,
  }) async {
    _isLoading = true;

    final response = await _carBrandsModelExtensionUseCase.call(
      id: id,
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<BasicModel>>? data = response;
      _getCarBrandsModelExtensionUseCaseResponse = data;
      log("getBrandsModels",
          _getCarBrandsModelExtensionUseCaseResponse!.data!.toString());
    } else {
      print("Fail getBrandsModels ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
