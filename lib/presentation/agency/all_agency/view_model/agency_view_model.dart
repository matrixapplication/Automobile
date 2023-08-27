import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:automobile_project/domain/use_case/agency/all_agency_use_case.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';

class AgencyViewModel extends ChangeNotifier {
  final AllAgencyUseCase _showRoomsUseCase;

  AgencyViewModel({
    required AllAgencyUseCase showRoomsUseCase,
  }) : _showRoomsUseCase = showRoomsUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasMore = true;

  int _page = 1;

  int get page => _page;

  bool get hasMore => _hasMore;

  ResponseModel<List<ShowRoomModel>>? _getAgenciesResponse;

  ResponseModel<List<ShowRoomModel>>? get getAgenciesResponse {
    return _getAgenciesResponse;
  }

  List<ShowRoomModel> _agencyList = [];

  List<ShowRoomModel> get allAgencyList {
    return _agencyList;
  }

  Future<ResponseModel<List<ShowRoomModel>?>?> getAgency(
      {required BuildContext context, bool isClear = false}) async {
    _isLoading = true;

    if (isClear) {
      clearData();
    }

    final response = await _showRoomsUseCase.call(
      context: context,
      page: _page,
    );

    if (response.isSuccess) {
      ResponseModel<List<ShowRoomModel>>? data = response;
      _getAgenciesResponse = data;
      log("getAgency", _getAgenciesResponse!.data!.toString());

      _agencyList.addAll(response.data!.map<ShowRoomModel>((e) {
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
    _getAgenciesResponse = null;
    _agencyList.clear();
  }
}
