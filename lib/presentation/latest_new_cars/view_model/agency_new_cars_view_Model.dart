

import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_my_cars_use_case.dart';
import 'package:flutter/material.dart';

class NewCarsAgencyViewModel extends ChangeNotifier {

  final GetMyCarUseCase _getCarsUseCase;

  NewCarsAgencyViewModel({
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
  List<CarModel> _showroomCarList = [];

  List<CarModel> get showroomCarList {
    return _showroomCarList;
  }

  List<CarModel> _agencyCarList = [];

  List<CarModel> get agencyCarList {
    return _agencyCarList;
  }


  void clearData() {
    _hasMore = true;
    _page = 1;
    _getResponse = null;
    _carList.clear();
    _showroomCarList.clear();
    _agencyCarList.clear();
  }

  ResponseModel<List<CarModel>>? _getResponse;

  ResponseModel<List<CarModel>>? get getResponse {
    return _getResponse;
  }

  Future<ResponseModel<List<CarModel>>> getMyCars(
      {
        required BuildContext context,
        required int? id,
        required String? modelRole,
        required String? states,
        bool isAll = false ,
      }) async {
    _isLoading = true;

    if (isAll) {
      clearData();
    }
    final responseModel = await _getCarsUseCase.call(
        context: context,
        id: id,
        modelRole: modelRole,
        states: states,
        brand: null,
        carModel: null,
        driveType: null,
        search:null,
        fuelType:null,
        startPrice:null,
        endPrice:null,
        startYear:null,
        endYear:null,
        page: _page);

    if (responseModel.isSuccess) {


      ResponseModel<List<CarModel>>? data = responseModel;
      _getResponse = data ;
      if(modelRole =="" || modelRole == null){
        _carList.addAll(responseModel.data!.map<CarModel>((e) {
          return e;
        }).toList());
      }else if(modelRole == "showroom"){
        _showroomCarList.addAll(responseModel.data!.map<CarModel>((e) {
          return e;
        }).toList());
      }else{
        _agencyCarList.addAll(responseModel.data!.map<CarModel>((e) {
          return e;
        }).toList());
      }
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
      print("success view Model data ${responseModel.data}");
    } else {
      print("Fail view Model ${responseModel.message}");
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}