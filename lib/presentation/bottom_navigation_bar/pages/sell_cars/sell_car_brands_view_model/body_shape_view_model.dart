import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/domain/use_case/drop_down/body_shape_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';

class BodyShapeViewModel extends ChangeNotifier {
  final BodyShapeUseCase _bodyShapeUseCase;

  BodyShapeViewModel({
    required BodyShapeUseCase bodyShapeUseCase,
  }) : _bodyShapeUseCase = bodyShapeUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<BasicModel>>? _getBodyShapeResponse;

  ResponseModel<List<BasicModel>>? get getBodyShapeResponse {
    return _getBodyShapeResponse;
  }

  Future<ResponseModel<List<BasicModel>?>?> getBodyShape(
      {required BuildContext context}) async {
    _isLoading = true;

    final response = await _bodyShapeUseCase.call(
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<BasicModel>>? data = response;
      _getBodyShapeResponse = data;
      log("get getBodyShape", _getBodyShapeResponse!.data!.toString());
    } else {
      print("Fail getBodyShape ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }

  String? _bodyShapeIndex;
  String? get bodyShapeKey => _bodyShapeIndex;
  changeBodyShapeIndex(String? index) {
    _bodyShapeIndex = index;
    notifyListeners();
  }
}
