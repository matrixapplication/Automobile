import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';
import '../../../../../domain/use_case/drop_down/brands_use_case.dart';

class CarBrandsViewModel extends ChangeNotifier {
  final CarBrandsUseCase _brandsUseCase;

  CarBrandsViewModel({
    required CarBrandsUseCase brandsUseCase,
  }) : _brandsUseCase = brandsUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<BasicModel>>? _getBrandsResponse;

  ResponseModel<List<BasicModel>>? get getBrandsResponse {
    return _getBrandsResponse;
  }

  Future<ResponseModel<List<BasicModel>?>?> getBrands({required BuildContext context}) async {
    _isLoading = true;

    final response = await _brandsUseCase.call(
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<BasicModel>>? data = response;
      _getBrandsResponse = data;
      log("get Brands", _getBrandsResponse!.data!.toString());
    } else {
      print("Fail getBrands ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
