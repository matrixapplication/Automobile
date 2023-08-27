import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/domain/use_case/drop_down/fuel_type_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/fuel_type_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';
import '../../../../../domain/use_case/drop_down/brands_use_case.dart';

class FuelTypeViewModel extends ChangeNotifier {
  final FuelTypeUseCase _fuelTypeUseCase;

  FuelTypeViewModel({
    required FuelTypeUseCase fuelTypeUseCase,
  }) : _fuelTypeUseCase = fuelTypeUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<BasicModel>>? _getFuelTypeResponse;

  ResponseModel<List<BasicModel>>? get getFuelTypeResponse {
    return _getFuelTypeResponse;
  }

  Future<ResponseModel<List<BasicModel>?>?> getFuelType({required BuildContext context}) async {
    _isLoading = true;

    final response = await _fuelTypeUseCase.call(
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<BasicModel>>? data = response;
      _getFuelTypeResponse = data;
      log("get Brands", _getFuelTypeResponse!.data!.toString());
    } else {
      print("Fail getBrands ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
