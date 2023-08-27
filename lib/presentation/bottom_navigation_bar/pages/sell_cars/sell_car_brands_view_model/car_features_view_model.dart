import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/feature_model/feature_model.dart';
import 'package:automobile_project/data/models/feature_model/feature_model.dart';
import 'package:automobile_project/data/models/feature_model/feature_model.dart';
import 'package:automobile_project/data/models/feature_model/feature_model.dart';
import 'package:automobile_project/domain/use_case/drop_down/body_shape_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/car_features_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/car_features_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/car_status_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';

class CarFeaturesViewModel extends ChangeNotifier {
  final CarFeaturesUseCase _carFeaturesUseCase;

  CarFeaturesViewModel({
    required CarFeaturesUseCase carFeaturesUseCase,
  }) : _carFeaturesUseCase = carFeaturesUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<FeatureModel>>? _getCarFeaturesResponse;

  ResponseModel<List<FeatureModel>>? get getCarFeaturesResponse {
    return _getCarFeaturesResponse;
  }

  Future<ResponseModel<List<FeatureModel>?>?> getCarFeatures(
      {required BuildContext context}) async {
    _isLoading = true;

    final response = await _carFeaturesUseCase.call(
      context: context,
    );

    if (response.isSuccess) {
      ResponseModel<List<FeatureModel>>? data = response;
      _getCarFeaturesResponse = data;
      log("get getCarFeatures", _getCarFeaturesResponse!.data!.toString());
    } else {
      print("Fail getCarFeatures ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }

  List<int> _selectedItems = []; // List to hold selected items
  List<int> get selectedItems => _selectedItems;

  updateBrands(bool value, int item) {
    if (value == true) {
      _selectedItems.add(item);
    } else {
      _selectedItems.remove(item);
    }
    notifyListeners();
  }

  clearData(){
    _selectedItems.clear() ;

  }
}
