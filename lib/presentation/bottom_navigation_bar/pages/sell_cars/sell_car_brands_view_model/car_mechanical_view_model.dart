import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/domain/use_case/drop_down/brand_models_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/mechanical_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/mechanical_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';
import '../../../../../domain/use_case/drop_down/brands_use_case.dart';

class CarMechanicalViewModel extends ChangeNotifier {
  final MechanicalUseCase _mechanicalUseCase;

  CarMechanicalViewModel({
    required MechanicalUseCase mechanicalUseCase,
  }) : _mechanicalUseCase = mechanicalUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<BasicModel>>? _getMechanicalResponse;

  ResponseModel<List<BasicModel>>? get getMechanicalResponse {
    return _getMechanicalResponse;
  }

  Future<ResponseModel<List<BasicModel>?>?> getMechanicalFun(
      {required BuildContext context}) async {
    _isLoading = true;

    final response = await _mechanicalUseCase.call(
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<BasicModel>>? data = response;
      _getMechanicalResponse = data;
      log("Mechanical", _getMechanicalResponse!.data!.toString());
    } else {
      print("Fail Mechanical ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }

  String? _transmissionIndex ;

  String?  get transmissionKey => _transmissionIndex;


  changeTransmissionIndex(String?  index) {
    _transmissionIndex = index;
    notifyListeners();
  }

}
