import 'dart:io';

import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/domain/entities/add_car_entity/add_car_entity.dart';
import 'package:automobile_project/domain/use_case/drop_down/fuel_type_use_case.dart';
import 'package:automobile_project/domain/use_case/drop_down/fuel_type_use_case.dart';
import 'package:automobile_project/domain/use_case/show_rooms/shoow_room_sell_car_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/base_response/response_model.dart';
import '../../../../../domain/logger.dart';
import '../../../../../domain/use_case/drop_down/brands_use_case.dart';

class ShowRoomSellCarViewModel extends ChangeNotifier {
  final ShowRoomsSellCarUseCase _showRoomsSellUseCase;

  ShowRoomSellCarViewModel({
    required ShowRoomsSellCarUseCase showRoomsSellUseCase,
  }) : _showRoomsSellUseCase = showRoomsSellUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ResponseModel? _getShowRoomsSellCarResponse;

  ResponseModel? get getShowRoomsSellCarResponse {
    return _getShowRoomsSellCarResponse;
  }

  Future<ResponseModel?> sellCar(
      {required BuildContext context, required SellCarEntity carData, required List<
          File?> images, required File mainImage}) async {
    _isLoading = true;

    final response = await _showRoomsSellUseCase.call(
        context: context,
        carEntity: carData,
        images: images,
        mainImage:mainImage
    );

    if (response.isSuccess) {
      ResponseModel data = response;
      _getShowRoomsSellCarResponse = data;
      log("sellCar", _getShowRoomsSellCarResponse.toString());
    } else {
      print("sellCar ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }


  Future<ResponseModel?> editCar(
      {required BuildContext context, required SellCarEntity carData, required List<
          File?> images, required File? mainImage , required int id}) async {
    _isLoading = true;

    final response = await _showRoomsSellUseCase.editCarCall(
        context: context,
        carEntity: carData,
        images: images,
        mainImage:mainImage ,
        id: id
    );

    if (response.isSuccess) {
      ResponseModel data = response;
      _getShowRoomsSellCarResponse = data;
      log("sellCar", _getShowRoomsSellCarResponse.toString());
    } else {
      print("sellCar ${response.message}");
    }

    _isLoading = false;
    notifyListeners();
    return response;
  }


  Future<ResponseModel> hideBranch(
      {required BuildContext context,required int id}) async {
    _isLoading = true;
    notifyListeners();

    final response =
    await _showRoomsSellUseCase.hide(context: context, id: id);

    if (response.isSuccess) {
    } else {
      if (kDebugMode) {
        print("Fail edit branch ${response.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return response;
  }
}
