import 'dart:io';

import 'package:automobile_project/domain/entities/add_car_entity/add_car_entity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/exceptions/api_error_handler.dart';
import '../../core/services/network/endpoints.dart';
import '../../domain/repository/show_rooms/show_rooms_repository.dart';
import '../data_sourse/remote/dio/dio_client.dart';
import '../models/base_response/api_response.dart';

class ShowRoomsRepository implements BaseShowRoomsRepository {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  ShowRoomsRepository(
      {required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> allShowRooms({
    required int page,
  }) async {
    try {
      final queryParameters = {"page": page, "limit": 15, "order": "desc"};

      final response = await dioClient?.get(
        queryParameters: queryParameters,
        EndPoints.getShowRoomApi,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> showRoomsBranches({required int id}) async {
    try {
      final response = await dioClient?.get(
        EndPoints.showRoomsBranchesApi,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> getDistricts({required int id}) async {
    try {
      final response = await dioClient?.get(
        "${EndPoints.getDistrictsApi}/$id",
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> getMyCarList({
    required int? page,
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
  }) async {
    try {
      final response =
          await dioClient?.get(EndPoints.getCarsApi, queryParameters: {
        "page": page,
        "limit": 15,
        "order": "desc",
        "model_role": modelRole,
        "id": id,
        'status': states,
        "brand": brand,
        "car_model": carModel !=null ? int.parse(carModel) : null,
        "search": search,
        "drive_type": driveType,
        "fuel_type": fuelType,
        "start_price": startPrice,
        "end_price": endPrice,
        "start_year": startYear,
        "end_year": endYear,
      });
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> getCities() async {
    try {
      final response = await dioClient?.get(
        EndPoints.getCitiesApi,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> showRoomsAddCar({
    required SellCarEntity carData,
    required List<File?> images,
    required File mainImage,
  }) async {
    final uploadList = <MultipartFile>[];
    for (final imageFiles in images) {
      uploadList.add(
        await MultipartFile.fromFile(
          imageFiles!.path,
          filename: imageFiles.path.split('/').last,
        ),
      );
    }

    FormData data = FormData.fromMap({
      "model_id": carData.modelId,
      "model_role": carData.modelRole,
      "brand_id": carData.brandId,
      "car_model_id": carData.carModelId,
      "car_model_extension_id": carData.carModelExtensionId,
      "branch_id": carData.branchId,
      "year": carData.year,
      "color_id": carData.color,
      "drive_type": carData.driveType,
      "car_type_id": carData.bodyType,
      "fuel_type": carData.fuelType,
      "status": carData.status,
      "price": carData.price,
      "doors": carData.doors,
      "engine": carData.engine,
      "cylinders": carData.cylinders,
      "mileage": carData.mileage,
      "description": carData.description,
      'main_image': await MultipartFile.fromFile(mainImage.path,
          filename: mainImage.path.split('/').last),
      'images[]': uploadList,
      'features[]': carData.selectedOptions,
    });
    try {
      final response = await dioClient?.post(
        EndPoints.addCarApi,
        data: data,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }

  @override
  Future<ApiResponse> addBranch({required formData}) async {
    FormData data = FormData.fromMap({
      "name[ar]": formData['name'],
      "name[en]": formData['name_en'],
      "address[en]": formData['address_en'],
      "address[ar]": formData['address'],
      "city_id": formData['city_id'],
      "district_id": formData['district_id'],
      "phone": formData['phone'],
      "whatsapp": formData['whatsapp']
    });
    try {
      final response = await dioClient?.post(
        EndPoints.addBranchApi,
        data: data,
      );

      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }

  @override
  Future<ApiResponse> allAgencies({
    required int page,
  }) async {
    try {
      final queryParameters = {"page": page, "limit": 7, "order": "desc"};

      final response = await dioClient?.get(
        queryParameters: queryParameters,
        EndPoints.getAgenciesApi,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> showRoomsBranchesById({required int id}) async {
    try {
      final response = await dioClient?.get(
        "${EndPoints.showBranchesById}/$id",
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> sortCars(
      {required String? order, required String? status}) async {
    try {
      final response =
          await dioClient?.get(EndPoints.getCarsApi, queryParameters: {
        "limit": 7,
        "order": "$order",
        "status": status,
      });
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> editBranch(
      {required Map<String, dynamic> formData, required int id}) async {
    FormData data = FormData.fromMap({
      "name[ar]": formData['name'],
      "name[en]": formData['name_en'],
      "address[en]": formData['address_en'],
      "address[ar]": formData['address'],
      "city_id": formData['city_id'],
      "district_id": formData['district_id'],
      "phone": formData['phone'],
      "whatsapp": formData['whatsapp']
    });
    try {
      final response = await dioClient?.post(
        "${EndPoints.editBranch}/$id",
        data: data,
      );

      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }

  @override
  Future<ApiResponse> hideBranch({required int id}) async {
    try {
      final response = await dioClient?.post(
        "${EndPoints.hideBranch}/$id",
      );

      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }

  @override
  Future<ApiResponse> showRoomEditCar(
      {required SellCarEntity carData,
      required List<File?> images,
        required int id ,
      required File? mainImage}) async {
    final uploadList = <MultipartFile>[];
    for (final imageFiles in images) {
      uploadList.add(
        await MultipartFile.fromFile(
          imageFiles!.path,
          filename: imageFiles.path.split('/').last,
        ),
      );
    }

    FormData data = FormData.fromMap({
      "model_id": carData.modelId,
      "model_role": carData.modelRole,
      "brand_id": carData.brandId,
      "car_model_id": carData.carModelId,
      "car_model_extension_id": carData.carModelExtensionId,
      "branch_id": carData.branchId,
      "year": carData.year,
      "color_id": carData.color,
      "drive_type": carData.driveType,
      "car_type_id": carData.bodyType,
      "fuel_type": carData.fuelType,
      "status": carData.status,
      "price": carData.price,
      "doors": carData.doors,
      "engine": carData.engine,
      "cylinders": carData.cylinders,
      "mileage": carData.mileage,
      "description": carData.description,
      'main_image': mainImage != null ? await MultipartFile.fromFile(mainImage.path,
          filename: mainImage.path.split('/').last) : null,
      'images[]': uploadList,
      'features[]': carData.selectedOptions,
    });

    print("Fields ===>${data.fields.toList()}");
    try {
      final response = await dioClient?.post(
        "${EndPoints.editCarApi}/$id",
        data: data,
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }

  @override
  Future<ApiResponse> isBayed({required int id}) async {
    try {
      final response = await dioClient?.get(
        "${EndPoints.isBayed}/$id",
      );

      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(error);
    }
  }

  @override
  Future<ApiResponse> showCarDetails({required int id}) async  {
    try {


      final response = await dioClient?.get(

        "${EndPoints.showCarDetails}/$id",
      );
      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }
}
