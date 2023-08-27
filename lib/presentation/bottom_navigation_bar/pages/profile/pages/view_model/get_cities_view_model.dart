import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:automobile_project/data/models/base_response/base_model.dart';
import 'package:automobile_project/data/models/base_response/response_model.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/feature_model/feature_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/save_role_usecase.dart';
import 'package:automobile_project/domain/use_case/show_rooms/get_cities_use_case.dart';
import 'package:automobile_project/domain/use_case/show_rooms/show_room_branches_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class GetCitiesViewModel extends ChangeNotifier {
  final GetCitiesUseCase _citiesUseCase;


  GetCitiesViewModel(
      {required GetCitiesUseCase citiesUseCase,
      })
      : _citiesUseCase = citiesUseCase
  ;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel<List<BasicModel>>? _getCitiesRespose;

  ResponseModel<List<BasicModel>>? get getCitiesRespose {
    return _getCitiesRespose;
  }


  Future<ResponseModel<List<BasicModel>>> getCities({
    required BuildContext context,

  }) async {
    _isLoading = true;

    final responseModel = await _citiesUseCase.call(
        context: context,
    );

    if (responseModel!.isSuccess) {

      ResponseModel<List<BasicModel>>? data = responseModel;
      _getCitiesRespose = data;


      if (kDebugMode) {
        print(data);

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
