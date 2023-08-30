import 'package:automobile_project/data/models/base_response/response_model.dart';


import 'package:automobile_project/domain/use_case/general/sliders_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:automobile_project/data/models/notification/notification.dart';

class AllNotificationViewModel extends ChangeNotifier{
  final SlidersUseCase _showSlidersUseCase;


  AllNotificationViewModel({required SlidersUseCase showSlidersUseCase,
  })
      : _showSlidersUseCase = showSlidersUseCase;


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasMore = true;

  int _page = 1;

  int get page => _page;

  bool get hasMore => _hasMore;

  List<Notifications> _notificationList = [];

  List<Notifications> get notificationList {
    return _notificationList;
  }

  ResponseModel<List<Notifications>>? _showNotificatinResponse;

  ResponseModel<List<Notifications>>? get showNotificatinResponse {
    return _showNotificatinResponse;
  }


  Future<ResponseModel<List<Notifications>>> allNotifications({
    required BuildContext context,
    required bool clear

  }) async {
    _isLoading = true;
    final responseModel = await _showSlidersUseCase.allNotification(
      context: context,
      page: _page
    );
    if (kDebugMode) {
      print(responseModel.data);
    }

    if(clear){
      clearData();
    }
    if (responseModel.isSuccess) {
      ResponseModel<List<Notifications>> data = responseModel;
      _notificationList.addAll(responseModel.data!.map<Notifications>((e) {
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


  clearData(){
    _showNotificatinResponse = null  ;
    _notificationList.clear() ;
    _hasMore  = false ;
    _page  = 0 ;
}


}