import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/domain/use_case/drop_down/brand_models_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';
import '../../../../../domain/use_case/drop_down/brands_use_case.dart';

class CarBrandsModelViewModel extends ChangeNotifier {
  final CarBrandsModelUseCase _brandModelsUseCase;

  CarBrandsModelViewModel({
    required CarBrandsModelUseCase brandModelsUseCase,
  }) : _brandModelsUseCase = brandModelsUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ResponseModel<List<BasicModel>>? _getBrandModelsResponse;

  ResponseModel<List<BasicModel>>? get getBrandModelsResponse {
    return _getBrandModelsResponse;
  }

  clearData(){
    _getBrandModelsResponse = null ;
    notifyListeners();
  }

  Future<ResponseModel<List<BasicModel>?>?> getBrandsModels(
      {required BuildContext context, required int brandId}) async {
    _isLoading = true;

    final response = await _brandModelsUseCase.call(
      brandId: brandId,
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<BasicModel>>? data = response;
      _getBrandModelsResponse = data;
      log("getBrandsModels", _getBrandModelsResponse!.data!.toString());
    } else {
      print("Fail getBrandsModels ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
