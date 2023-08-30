

// ignore_for_file: use_build_context_synchronously

import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/domain/use_case/fav_use_case/fav_use_case.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/get_user_data_usecase.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/get_user_role_usecase.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/save_role_usecase.dart';
import 'package:automobile_project/presentation/component/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/base_response/response_model.dart';
import '../../../../domain/use_case/authentication_use_case/show_room_login_use_case.dart';
import '../../../../domain/use_case/local_use_cases/save_data_usecase.dart';
import '../../../../domain/use_case/local_use_cases/save_user_usecase.dart';

class FavViewModel extends ChangeNotifier {
  final FavUseCase _favUseCase ;


  bool _isLoading = false;

  FavViewModel({
    required FavUseCase favUseCase
}) : _favUseCase = favUseCase;

  bool get isLoading => _isLoading;

  ResponseModel<List<CarModel>>? _showFavCarsResponse;

  ResponseModel<List<CarModel>>? get showFavCarsResponse {
    return _showFavCarsResponse;
  }

  Future<ResponseModel<BasicModel>> addRemoveFav({
    required BuildContext context,
    required int carId,
    required CarModel car

  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _favUseCase.call(
      context: context,
      carId: carId
    );

    if (responseModel!.isSuccess) {
      showCustomSnackBar(message: "${responseModel.message}", context: context) ;
      if(_showFavCarsResponse != null){
        if(_showFavCarsResponse!.data!.any((element) => element.id == carId)){
          _showFavCarsResponse?.data?.removeWhere((element) => carId == element.id,);
        }else{
          _showFavCarsResponse?.data?.add(car) ;
        }
      }
    } else {
      showCustomSnackBar(message: "${responseModel.message}", context: context) ;
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel<List<CarModel>>> getMyCars({
    required BuildContext context,
  }) async {
    _isLoading = true;
    final responseModel = await _favUseCase.showFavCall(
        context: context,
    );
    print(responseModel.data);
    if (responseModel.isSuccess) {
      ResponseModel<List<CarModel>>? data = responseModel;
      _showFavCarsResponse = data;
      print("success view Model data ${responseModel.data}");
    } else {
      print("Fail view Model ${responseModel.message}");
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }





}
