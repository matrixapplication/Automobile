

import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_my_cars_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SortPageViewModel extends ChangeNotifier {

  final GetMyCarUseCase _getCarsUseCase;

  SortPageViewModel({
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
        required String? order,
        required String? status,
        bool isAll = false ,
      }) async {
    _isLoading = true;
    if (isAll) {
      clearData();
    }
    final responseModel = await _getCarsUseCase.callSortBy(context: context, order: order, page: _page, status: status);
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