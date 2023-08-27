import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/track_request_model/track_request.dart';
import 'package:automobile_project/domain/use_case/general/sliders_use_case.dart';
import 'package:automobile_project/domain/use_case/general/track_request_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TrackYourRequestViewModel extends ChangeNotifier{
  final TrackYourRequestUseCase _showSlidersUseCase;


  TrackYourRequestViewModel({required TrackYourRequestUseCase showSlidersUseCase,
  })
      : _showSlidersUseCase = showSlidersUseCase;


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  TrackRequestModel? _response ;
  TrackRequestModel? get response{
    return _response ;
  }
  void clearData(){
    _response = null ;
}
  Future<ResponseModel<TrackRequestModel>> trackUrRequest({
    required BuildContext context,
    required String phone ,
  }) async {
    _isLoading = true;
    notifyListeners();
    final responseModel = await _showSlidersUseCase.call(context: context, phone: phone);
    if (kDebugMode) {

    }
    if (responseModel.isSuccess) {
      _response = responseModel.data ;
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