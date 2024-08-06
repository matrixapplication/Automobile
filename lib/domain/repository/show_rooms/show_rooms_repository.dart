import 'dart:io';

import 'package:dio/dio.dart';

import '../../../data/models/base_response/api_response.dart';
import '../../../data/models/puechase_order.dart';
import '../../entities/add_car_entity/add_car_entity.dart';

mixin BaseShowRoomsRepository {
  Future<ApiResponse> allShowRooms({
    required int page,
  });
  Future<ApiResponse> allAgencies({
    required int page,
  });
  Future<ApiResponse> showRoomsBranches({required int id});
  Future<ApiResponse> showRoomsBranchesById({required int id});
  Future<ApiResponse> getCities();
  Future<ApiResponse> sendPurchaseOrder(PurchaseOrderParams params);
  Future<ApiResponse> getMyCarList(
      {
        required int? page ,
        required int? id,
        required String? modelRole,
        required String? states,
        required String? brand,
        required String? carModel,
        required String? driveType,
        required String? search,
        required String? fuelType,
        required String? startPrice,
        required String? endPrice,
        required String? startYear,
        required String? endYear,
      });
  Future<ApiResponse> getDistricts({required int id});
  Future<ApiResponse> showRoomsAddCar({
    required SellCarEntity carData,
    required List<File?> images,
    required File mainImage,
  });
  Future<ApiResponse> showRoomEditCar({
    required SellCarEntity carData,
    required List<File?> images,
    required File? mainImage,
    required int id
  });

  Future<ApiResponse> addBranch({
    required Map<String, dynamic> formData,
  });
  Future<ApiResponse> editBranch({
    required Map<String, dynamic> formData,
    required int id
  });
  Future<ApiResponse> hideBranch({
    required int id
  });

  Future<ApiResponse> sortCars({required String? order , required String? status}) ;

  Future<ApiResponse> isBayed({
    required int id
  });

  Future<ApiResponse> showCarDetails({
    required int id
  });





}
