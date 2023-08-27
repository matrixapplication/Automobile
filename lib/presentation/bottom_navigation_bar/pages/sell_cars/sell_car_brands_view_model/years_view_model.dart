import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';
import '../../../../../domain/use_case/drop_down/brands_use_case.dart';
import '../../../../../domain/use_case/drop_down/years_use_case.dart';

class YearsViewModel extends ChangeNotifier {
  final YearsUseCase _yearsUseCase;

  YearsViewModel({
    required YearsUseCase yearsUseCase,
  }) : _yearsUseCase = yearsUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<int>>? _getYearsResponse;

  ResponseModel<List<int>>? get getYearsResponse {
    return _getYearsResponse;
  }

  Future<ResponseModel<List<int>?>?> getYears(
      {required BuildContext context}) async {
    _isLoading = true;

    final response = await _yearsUseCase.call(
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<int>>? data = response;
      _getYearsResponse = data;
      log("getYears", _getYearsResponse!.data!.toString());
    } else {
      print("Fail getYears ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }
}
