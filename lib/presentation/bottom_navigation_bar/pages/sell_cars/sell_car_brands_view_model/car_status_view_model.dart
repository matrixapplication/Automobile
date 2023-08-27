import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/domain/use_case/drop_down/body_shape_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/car_status_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';

class CarStatusViewModel extends ChangeNotifier {
  final CarStatusUseCase _carStatusUseCase;

  CarStatusViewModel({
    required CarStatusUseCase carStatusUseCase,
  }) : _carStatusUseCase = carStatusUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<BasicModel>>? _getCarStatusResponse;

  ResponseModel<List<BasicModel>>? get getCarStatusResponse {
    return _getCarStatusResponse;
  }

  Future<ResponseModel<List<BasicModel>?>?> getCarStatus(
      {required BuildContext context}) async {
    _isLoading = true;

    final response = await _carStatusUseCase.call(
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<BasicModel>>? data = response;
      _getCarStatusResponse = data;
      log("get getCarStatus", _getCarStatusResponse!.data!.toString());
    } else {
      print("Fail getCarStatus ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
