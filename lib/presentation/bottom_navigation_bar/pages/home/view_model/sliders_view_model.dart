import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/slider/slider_model.dart';
import 'package:automobile_project/domain/use_case/general/sliders_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SlidersViewModel extends ChangeNotifier{
  final SlidersUseCase _showSlidersUseCase;


  SlidersViewModel({required SlidersUseCase showSlidersUseCase,
  })
      : _showSlidersUseCase = showSlidersUseCase;


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<SlidersModel>>? _showSlidersResponse;

  ResponseModel<List<SlidersModel>>? get showSlidersResponse {
    return _showSlidersResponse;
  }


  Future<ResponseModel<List<SlidersModel>>> showSliders({
    required BuildContext context,

  }) async {
    _isLoading = true;
    final responseModel = await _showSlidersUseCase.call(
        context: context,
    );
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      ResponseModel<List<SlidersModel>>? data = responseModel;
      _showSlidersResponse = data ;
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