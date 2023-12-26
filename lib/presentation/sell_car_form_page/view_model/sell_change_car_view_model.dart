import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/slider/slider_model.dart';
import 'package:automobile_project/domain/use_case/general/sliders_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SellChangeCarViewModel extends ChangeNotifier{
  final SlidersUseCase _showSlidersUseCase;


  SellChangeCarViewModel({required SlidersUseCase showSlidersUseCase,
  })
      : _showSlidersUseCase = showSlidersUseCase;


  bool _isLoading = false;

  bool get isLoading => _isLoading;



  Future<ResponseModel> sellChangeCar({
    required BuildContext context,
    required Map<String , dynamic> formData ,
  }) async {
    _isLoading = true;
    final responseModel = await _showSlidersUseCase.callSellChangeCar(
      context: context,
      formData: formData
    );
    if (kDebugMode) {

    }
    if (responseModel.isSuccess) {

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

  offLoading(){
    _isLoading = false;
    notifyListeners();
  }
}