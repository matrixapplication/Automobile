

import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_my_cars_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilterPageViewModel extends ChangeNotifier {

  final GetMyCarUseCase _getCarsUseCase;

  FilterPageViewModel({
    required GetMyCarUseCase showRoomsBranchesUseCase,
  }) : _getCarsUseCase = showRoomsBranchesUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasMore = true;

  int _page = 1;

  int get page => _page;

  bool get hasMore => _hasMore;

  List<CarModel> _carList = [];

  List<CarModel> get carList {
    return _carList;
  }



  void clearData() {
    _hasMore = true;
    _page = 1;
    _getResponse = null;
    _carList.clear();
  }

  ResponseModel<List<CarModel>>? _getResponse;

  ResponseModel<List<CarModel>>? get getResponse {
    return _getResponse;
  }

  Future<ResponseModel<List<CarModel>>> getMyCars(
      {
        required BuildContext context,
        required String? states,
        required String? brand,
        required String? driveType,
        required String? fuelType,
        required String? startPrice,
        required String? endPrice,
        required String? startYear,
        required String? endYear,
        required String? search,
        required String? carModel ,
        bool isAll = false ,
      }) async {
    _isLoading = true;
    notifyListeners()  ;
    if (isAll) {
      clearData();
    }
    final responseModel = await _getCarsUseCase.call(
        context: context,
        id: null,
        modelRole: null,
        states: states,
        brand: brand,
        driveType: driveType,
        search: search,
        fuelType: fuelType,
        startPrice: startPrice,
        endPrice: endPrice,
        startYear: startYear,
        endYear: endYear,
        page: _page,
        carModel:carModel);
    if (responseModel.isSuccess) {
      ResponseModel<List<CarModel>>? data = responseModel;
      _getResponse = data ;
      _carList.addAll(responseModel.data!.map<CarModel>((e) {
        return e;
      }).toList());
      if (_page <= responseModel.pagination!.totalPages!) {
        if (_page == responseModel.pagination!.totalPages!) {
          _hasMore = false;
        }
        notifyListeners();
        _page = _page + 1;
      } else {
        _hasMore = false;
        notifyListeners();
      }
      if (kDebugMode) {
        print("success view Model data ${responseModel.data}");
      }
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}