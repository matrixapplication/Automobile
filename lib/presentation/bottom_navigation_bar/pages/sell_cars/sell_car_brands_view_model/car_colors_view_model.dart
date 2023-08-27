import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/domain/use_case/drop_down/car_colors_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';
import '../../../../../domain/use_case/drop_down/brands_use_case.dart';

class CarColorsViewModel extends ChangeNotifier {
  final CarColorsUseCase _colorsUseCase;

  CarColorsViewModel({
    required CarColorsUseCase colorsUseCase,
  }) : _colorsUseCase = colorsUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<BasicModel>>? _getColorsResponse;

  ResponseModel<List<BasicModel>>? get getColorsResponse {
    return _getColorsResponse;
  }

  Future<ResponseModel<List<BasicModel>?>?> getColors({required BuildContext context}) async {
    _isLoading = true;

    final response = await _colorsUseCase.call(
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<BasicModel>>? data = response;
      _getColorsResponse = data;
      log("get colors", _getColorsResponse!.data!.toString());
    } else {
      print("Fail get colors ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
