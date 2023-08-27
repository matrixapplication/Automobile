import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_my_cars_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GetMyCarsViewModel extends ChangeNotifier {
  final GetMyCarUseCase _showRoomsBranchesUseCase;

  GetMyCarsViewModel({
    required GetMyCarUseCase showRoomsBranchesUseCase,
  }) : _showRoomsBranchesUseCase = showRoomsBranchesUseCase;

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
    _showRoomsBranchesResponse = null;
    _carList.clear();
  }

  ResponseModel<List<CarModel>>? _showRoomsBranchesResponse;

  ResponseModel<List<CarModel>>? get showRoomsBranchesResponse {
    return _showRoomsBranchesResponse;
  }

   List<CarModel> _allCars = [];

  List<CarModel> get allCars {
    return _allCars;
  }

  ResponseModel<List<CarModel>>? _usedCars;

  ResponseModel<List<CarModel>>? get usedCars {
    return _usedCars;
  }

  ResponseModel<List<CarModel>>? _newCars;

  ResponseModel<List<CarModel>>? get newCars {
    return _newCars;
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
    final responseModel = await _showRoomsBranchesUseCase.call(
        context: context,
        id: id,
        modelRole: modelRole,
        states: states,
        brand:null,
        carModel:null,
        driveType:null,
        search:null,
        fuelType:null,
        startPrice:null,
        endPrice:null,
        startYear:null,
        endYear:null,
        page: _page);
    if (responseModel.isSuccess) {
      ResponseModel<List<CarModel>>? data = responseModel;
      _showRoomsBranchesResponse = data ;
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
      print("success view Model data ${responseModel.data}");
    } else {
      print("Fail view Model ${responseModel.message}");
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel<List<CarModel>>> getUsedCars({
    required BuildContext context,
    required int? id,
    required String modelRole,
    required String states,
  }) async {
    _isLoading = true;
    final responseModel = await _showRoomsBranchesUseCase.call(
        context: context,
        id: id,
        modelRole: modelRole,
        states: states,
        brand:null,
        carModel:null,
        driveType:null,
        search:null,
        fuelType:null,
        startPrice:null,
        endPrice:null,
        startYear:null,
        endYear:null,
        page: null);

    if (responseModel.isSuccess) {
      ResponseModel<List<CarModel>>? data = responseModel;
      _usedCars = data;
      print("success view Model data ${responseModel.data}");
    } else {
      print("Fail view Model ${responseModel.message}");
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel<List<CarModel>>> getNewCars({
    required BuildContext context,
    required int? id,
    required String modelRole,
    required String states,
  }) async {
    _isLoading = true;

    final responseModel = await _showRoomsBranchesUseCase.call(
        context: context,
        id: id,
        modelRole: modelRole,
        states: states,
        brand:null,
        carModel:null,
        driveType:null,
        search: null,
        fuelType:null,
        startPrice:null,
        endPrice:null,
        startYear:null,
        endYear:null,
        page: null);
    if (responseModel.isSuccess) {
      ResponseModel<List<CarModel>>? data = responseModel;
      _newCars = data;
      print("success view Model data ${responseModel.data}");
    } else {
      print("Fail view Model ${responseModel.message}");
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  // Future<ResponseModel> hideBranch(
  //     {required BuildContext context,required int id}) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   final response =
  //   await _showRoomsBranchesUseCase.hide(context: context, id: id);
  //
  //   if (response.isSuccess) {
  //     _showRoomsBranchesResponse!.data!.removeWhere((element) => element.id == id) ;
  //   } else {
  //     if (kDebugMode) {
  //       print("Fail edit branch ${response.message}");
  //     }
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  //   return response;
  // }

}
