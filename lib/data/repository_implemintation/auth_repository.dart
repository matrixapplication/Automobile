import 'dart:io';

import 'package:automobile_project/main.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/exceptions/api_error_handler.dart';
import '../../core/services/network/endpoints.dart';
import '../../domain/repository/authentication/authentication_repository.dart';
import '../data_sourse/remote/dio/dio_client.dart';
import '../models/base_response/api_response.dart';

class AuthRepository implements BaseAuthenticationRepository {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  AuthRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future<ApiResponse> showRoomLogin({
    required String? code,
    required String? password,
  }) async {
    String fcm = await FirebaseMessaging.instance.getToken() ?? "";
    try {
      final response = await dioClient?.post(
        EndPoints.showRoomLoginApi,
        body: {'code': code, 'password': password, "fcm_token": fcm},
      );

      print("response.data ${response?.data}");
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
  Future<ApiResponse> logOut() async {
    try {
      final response = await dioClient!.post(
        "${NetworkPath.hostName}/api/v1/logout",
      );
      return ApiResponse.withSuccess(response);
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
  Future<ApiResponse> endUserLogin({required String? email, required String? password}) async {
    String fcm = await FirebaseMessaging.instance.getToken() ?? "";
    try {
      final response = await dioClient?.post(
        EndPoints.endUserLogin,
        body: {'email': email, 'password': password, "fcm_token": fcm},
      );

      print("response.data ${response?.data}");
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
  Future<ApiResponse> endUserRegister({required String? name, required String? email, required String? phone, required String? password, required String? confirmPassword, required String? image}) async {
    try {
      final response = await dioClient?.post(
        EndPoints.endUserRegister,
        body: {'email': email, 'name': name, 'phone': phone, 'password': password, 'password_confirmation': confirmPassword, 'fcm_token': sharedPreferences!.getString("fcm")},
      );

      print("response.data ${response?.data}");
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
  Future<ApiResponse> getEndUser({required String token}) async {
    try {
      final response = await dioClient?.get(EndPoints.getEndUser, options: Options(headers: {"Authorization": "Bearer $token"}));

      print("response.data ${response?.data}");
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
  Future<ApiResponse> getShowRoom() async {
    try {
      final response = await dioClient?.get(
        EndPoints.getShowRoomData,
        // options: Options(headers: {"Authorization": "Bearer $token"})
      );

      print("response.data ${response?.data}");
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
  Future<ApiResponse> endUserEditProfile({
    required String? name,
    required String? email,
    required String? phone,
    required String? password,
    required String? confirmPassword,
  }) async {
    try {
      final response = await dioClient?.post(
        EndPoints.editEndUser,
        body: {'email': email, 'name': name, 'phone': phone, 'password': password, 'password_confirmation': confirmPassword},
      );

      print("response.data ${response?.data}");
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
  Future<ApiResponse> endShowRoomEditProfile({required String? name, required String? showRoomName, required String? code, required String? phone, required String? whatsApp, required String? password, required String? confirmPassword, required String? coverImage}) async {
    try {
      final response = await dioClient?.post(
        EndPoints.editShowRoomProfile,
        data: FormData.fromMap({'code': code, 'owner_name': name, 'showroom_name': showRoomName, 'phone': phone, 'whatsapp': whatsApp, 'password': password, 'password_confirmation': confirmPassword, "cover_image": coverImage != null ? await MultipartFile.fromFile(coverImage, filename: coverImage.split('/').last) : null}),
      );
      if (kDebugMode) {
        print("response.data ${response?.data}");
      }
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
  Future<ApiResponse> uploadImage({required File image}) async {
    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
    });
    try {
      final response = await dioClient?.post(EndPoints.userUploadImage, data: data, options: Options(headers: {"Authorization": "Bearer ${shared!.getString("token")}"}));

      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        print(error);

        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      print(error.response!);

      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      print(error);
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> uploadShowRoomImage({required File image}) async {
    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
    });
    try {
      final response = await dioClient?.post(EndPoints.showroomUploadImage, data: data, options: Options(headers: {"Authorization": "Bearer ${shared!.getString("token")}"}));

      return ApiResponse.withSuccess(response!);
    } on DioError catch (error) {
      if (error.response == null) {
        print(error);

        return ApiResponse.withError(ApiErrorHandler.getMessage(error));
      }
      print(error.response!);

      return ApiResponse.withSuccess(error.response!);
    } catch (error) {
      print(error);
      return ApiResponse.withError(ApiErrorHandler.getMessage(error));
    }
  }

  @override
  Future<ApiResponse> deleteAccount() async {
    try {
      final response = await dioClient?.post(
        EndPoints.deleteAccount,
        options: Options(headers: {"Authorization": "Bearer ${shared!.getString("token")}"}),
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
