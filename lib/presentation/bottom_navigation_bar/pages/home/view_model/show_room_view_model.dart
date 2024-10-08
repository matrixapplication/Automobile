import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/alerts.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../data/models/puechase_order.dart';
import '../../../../../domain/logger.dart';
import '../../../../../domain/use_case/show_rooms/show_rooms_use_case.dart';

class ShowRoomsViewModel extends ChangeNotifier {
  final ShowRoomsUseCase _showRoomsUseCase;

  ShowRoomsViewModel({
    required ShowRoomsUseCase showRoomsUseCase,
  }) : _showRoomsUseCase = showRoomsUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  int _page = 1;
  bool _hasMore = true;

  int get page => _page;

  bool get hasMore => _hasMore;

  ResponseModel<List<ShowRoomModel>>? _getShowRoomsResponse;

  ResponseModel<List<ShowRoomModel>>? get getShowRoomsResponse {
    return _getShowRoomsResponse;
  }
  ResponseModel<List<ShowRoomModel>>? _getAgenciesResponse;

  ResponseModel<List<ShowRoomModel>>? get getAgenciesResponse {
    return _getAgenciesResponse;
  }

  List<ShowRoomModel> _showRoomsList = [];

  List<ShowRoomModel> get showRoomsList {
    return _showRoomsList;
  }

  List<ShowRoomModel> _agenciesList = [];

  List<ShowRoomModel> get agenciesList {
    return _agenciesList;
  }




  Future<ResponseModel<List<ShowRoomModel>?>?> getShowRooms(
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
      _getShowRoomsResponse = data;
      log("getShowRooms", _getShowRoomsResponse!.data!.toString());

      _showRoomsList.addAll(response.data!.map<ShowRoomModel>((e) {

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

  Future sendPurchaseOrder(PurchaseOrderParams params,context) async {
    _isLoading = true;
    final response = await _showRoomsUseCase.sendPurchaseOrder(params, context);
    if(response!.isSuccess){
      Alerts.showSnackBar(context, 'Successfully',forError: false);
      Navigator.of(context).pop();
    }
    _isLoading = false;
    notifyListeners();
    return response;
  }


  Future<ResponseModel<List<ShowRoomModel>?>?> getAgencies(
      {required BuildContext context, bool isClear = false}) async {
    _isLoading = true;

    if (isClear) {
      clearDataAgencies();
    }

    final response = await _showRoomsUseCase.callAgency(
      context: context,
      page: _page,
    );

    if (response.isSuccess) {
      ResponseModel<List<ShowRoomModel>>? data = response;
      _getAgenciesResponse = data;


      _agenciesList.addAll(response.data!.map<ShowRoomModel>((e) {
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
    _getShowRoomsResponse = null;
    _showRoomsList.clear();
  }


  void clearDataAgencies() {
    _hasMore = true;
    _page = 1;
    _getAgenciesResponse = null;
    _agenciesList.clear();
  }
}
