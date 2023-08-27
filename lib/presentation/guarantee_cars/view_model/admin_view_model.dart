import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:automobile_project/data/models/car_model/admin_car_model.dart';
import 'package:automobile_project/domain/use_case/admin/admin_use_case.dart';
import 'package:automobile_project/domain/use_case/agency/all_agency_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';

class AdminViewModel extends ChangeNotifier {
  final AdminUseCase _adminUseCase;

  AdminViewModel({
    required AdminUseCase adminUseCase,
  }) : _adminUseCase = adminUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasMore = true;

  int _page = 1;

  int get page => _page;

  bool get hasMore => _hasMore;

  ResponseModel<List<AdminCars>>? _getAdminCarsResponse;

  ResponseModel<List<AdminCars>>? get getAdminCarsResponse {
    return _getAdminCarsResponse;
  }

  List<AdminCars> _adminCarsList = [];

  List<AdminCars> get adminCarsList {
    return _adminCarsList;
  }

  Future<ResponseModel<List<AdminCars>?>?> getAdminCars(
      {required BuildContext context, bool isClear = false}) async {
    _isLoading = true;

    if (isClear) {
      clearData();
    }

    final response = await _adminUseCase.call(
      context: context,
      page: _page,
    );

    if (response.isSuccess) {
      ResponseModel<List<AdminCars>>? data = response;
      _getAdminCarsResponse = data;
      log("getAdminCars", _getAdminCarsResponse!.data!.toString());

      _adminCarsList.addAll(response.data!.map<AdminCars>((e) {
        return e;
      }).toList());

      if (_page <= response.pagination!.totalPages!) {
        if (_page == response.pagination!.totalPages!) {
          _hasMore = false;
        }
        notifyListeners();
        _page = _page + 1;
      } else {
        _hasMore = false;
        notifyListeners();
      }
    } else {
      print("Fail view Model ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }

  void clearData() {
    _hasMore = true;
    _page = 1;
    _getAdminCarsResponse = null;
    _adminCarsList.clear();
  }
}
