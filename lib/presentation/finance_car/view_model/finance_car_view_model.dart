import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../data/models/finance_car_model.dart';
import '../../../domain/use_case/finance_car/finance_car_use_case.dart';

class FinanceCarViewModel extends ChangeNotifier {
  final FinanceCarUseCase _financeCarUseCase;


  FinanceCarViewModel({required FinanceCarUseCase financeCarUseCase,
  })
      : _financeCarUseCase = financeCarUseCase;


  bool _isLoading = false;

  bool get isLoading => _isLoading;



  Future<ResponseModel> financeCar({
    required BuildContext context,
    required Map<String , dynamic> formData ,
  }) async
  {
    _isLoading = true;
    final responseModel = await _financeCarUseCase.financeCar(
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

  Future<ResponseModel> financeAddOfferCar({
    required BuildContext context,
    required Map<String , dynamic> formData ,
  }) async
  {
    _isLoading = true;
    final responseModel = await _financeCarUseCase.financeAddOfferCar(
        context: context,
        formData: formData
    );

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
  Future<String?> getContactUs(context)async{
    return  await _financeCarUseCase.getContactUs(context: context).then((value){
      if(value.isSuccess){
        print("success view sModel data ${value.data}");
        return value.data['phone'];
      }else{
        return null;
      }
    });
  }

  Future<List<FinanceCarModel>?> getFinanceCar(context)async{
    return  await _financeCarUseCase.getFinanceCar(context: context, page: 1).then((value){
      if(value.isSuccess){
        print("success view sModel data ${value.data}");
        return value.data;
      }else{
        return null;
      }
    });
  }

  offLoading(){
    _isLoading = false;
    notifyListeners();
  }
}