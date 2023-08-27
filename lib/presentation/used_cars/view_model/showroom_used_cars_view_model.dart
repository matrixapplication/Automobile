

import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_my_cars_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UsedCarsShowRoomViewModel extends ChangeNotifier {

  final GetMyCarUseCase _getCarsUseCase;

  UsedCarsShowRoomViewModel({
    required GetMyCarUseCase showRoomsBranchesUseCase,
  }) : _getCarsUseCase = showRoomsBranchesUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool _hasMor2 = true;

  int _page = 1;
  int _page2 = 1;

  int get page => _page;
  int get page2 => _page2;

  bool get hasMore => _hasMore;
  bool get hasMore2 => _hasMor2;

  List<CarModel> _carList = [];

  List<CarModel> get carList {
    return _carList;
  }


  List<CarModel> _shocarList = [];

  List<CarModel> get shocarList {
    return _shocarList;
  }



  void clearData() {
    _hasMore = true;
    _page = 1;
    _getResponse = null;
    _carList.clear();


  }
  void clearShowroomData() {
    _hasMore = true;
    _page2 = 1;
    _getResponse = null;
    _shocarList.clear();


  }

  // void clearDataShooRoom() {
  //   _hasMore = true;
  //   _page = 1;
  //   _getResponse = null;
  //
  //   _showroomCarList.clear();
  //
  // }

  ResponseModel<List<CarModel>>? _getResponse;

  ResponseModel<List<CarModel>>? get getResponse {
    return _getResponse;
  }

  Future<ResponseModel<List<CarModel>>>  getMyCars(
      {
        required BuildContext context,
        required int? id,
        required String? modelRole,
        required String? states,
        bool isAll = false ,
      }) async {
    _isLoading = true;
      if(modelRole =='showroom'){
        if (isAll) {
          clearShowroomData();
        }
      }else{
        if (isAll) {
          clearData();
        }
      }


    final responseModel = await _getCarsUseCase.call(
        context: context,
        id: id,
        modelRole: modelRole,
        states: states,
        brand: null,
        carModel: null,
        driveType: null,
        search: null,
        fuelType: null,
        startPrice: null,
        endPrice: null,
        startYear: null,
        endYear: null,
        page:modelRole =='showroom' ?  _page2 : _page);

    if (responseModel.isSuccess) {


      ResponseModel<List<CarModel>>? data = responseModel;
      _getResponse = data ;
      if(modelRole =='showroom'){
        _shocarList.addAll(responseModel.data!.map<CarModel>((e) => e).toList()) ;
      }else{
        _carList.addAll(responseModel.data!.map<CarModel>((e) {
          return e;
        }).toList());
      }

        if(modelRole == 'showroom'){
          if (_page2 <= responseModel.pagination!.totalPages!) {
            if (_page2 == responseModel.pagination!.totalPages!) {
              _hasMor2 = false;
            }
            notifyListeners();
            _page2 = _page2 + 1;
          } else {
            _hasMor2 = false;
            notifyListeners();
          }
        }else{
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