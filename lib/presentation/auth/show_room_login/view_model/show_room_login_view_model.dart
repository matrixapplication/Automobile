// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/get_user_data_usecase.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/get_user_role_usecase.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/save_role_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/base_response/response_model.dart';
import '../../../../domain/use_case/authentication_use_case/show_room_login_use_case.dart';
import '../../../../domain/use_case/local_use_cases/save_data_usecase.dart';
import '../../../../domain/use_case/local_use_cases/save_user_usecase.dart';

class ShowRoomLoginViewModel extends ChangeNotifier {
  final ShowRoomLoginUseCase _signInUseCase;
  final SaveTokenDataUseCase _saveUserTokenUseCase;
  final SaveRoleDataUseCase _saveRoleUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  final GetUserRoleUseCase _getUserRoleUseCase;
  ShowRoomLoginViewModel({required ShowRoomLoginUseCase loginUseCase, required SaveTokenDataUseCase saveUserTokenUseCase, required SaveRoleDataUseCase saveRoleUseCase, required SaveUserDataUseCase saveUserDataUseCase, required GetUserDataUseCase getUserDataUseCase, required GetUserRoleUseCase getUserRoleUseCase})
      : _signInUseCase = loginUseCase,
        _saveUserTokenUseCase = saveUserTokenUseCase,
        _saveRoleUseCase = saveRoleUseCase,
        _saveUserDataUseCase = saveUserDataUseCase,
        _getUserDataUseCase = getUserDataUseCase,
        _getUserRoleUseCase = getUserRoleUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  ShowRoomModel? _userModel;
  ShowRoomModel? get userModel {
    return _userModel;
  }

  Future<ResponseModel<ShowRoomModel>> login({
    required BuildContext context,
    required String code,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _signInUseCase.call(
      context: context,
      password: password,
      code: code,
    );

    if (responseModel.isSuccess) {
      String? token = responseModel.data!.token.toString();
      String? role = responseModel.data!.role.toString();
      _saveUserTokenUseCase.call(token: token, userModel: responseModel.data!);
      _saveRoleUseCase.call(role: role);
      _saveUserDataUseCase.call(userModel: responseModel.data!);
      await _getUserDataUseCase.call();
      await _getUserRoleUseCase.call();
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel<ShowRoomModel>> getShowRoomData({
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _signInUseCase.callShowRoomData(
      context: context,
    );
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      String? role = responseModel.data!.role.toString();
      if (kDebugMode) {
        print("success view Model role $role");
        print("success view Model data ${responseModel.data}");
      }
      _saveRoleUseCase.call(role: role);
      _saveUserDataUseCase.call(userModel: responseModel.data!);
      await _getUserDataUseCase.call();
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel<ShowRoomModel>> editProfileShowRoom({
    required BuildContext context,
    required String name,
    required String showRoomName,
    required String code,
    required String phone,
    required String whatsApp,
    required String password,
    required String confirmPassword,
    required String? coverImage,
  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _signInUseCase.editShowRoomCall(context: context, name: name, showRoomName: showRoomName, phone: phone, password: password, whatsApp: whatsApp, email: code, confirmPassword: confirmPassword, coverImage: coverImage);
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      String? role = responseModel.data!.role.toString();
      if (kDebugMode) {
        print("success view Model role $role");
        print("success view Model data ${responseModel.data}");
      }
      _saveRoleUseCase.call(role: role);
      _saveUserDataUseCase.call(userModel: responseModel.data!);
      await _getUserDataUseCase.call();
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel<ShowRoomModel>> userUploadImage({
    required BuildContext context,
    required File image,
  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _signInUseCase.userImageUpload(context: context, image: image);
    if (kDebugMode) {
      print(responseModel.message);
    }
    if (responseModel.isSuccess) {
      String? role = responseModel.data!.role.toString();
      if (kDebugMode) {
        print("success view Model role $role");
        print("success view Model data ${responseModel.data}");
      }
      _userModel = responseModel.data!;
      _saveRoleUseCase.call(role: role);
      _saveUserDataUseCase.call(userModel: responseModel.data!);
      await _getUserDataUseCase.call();
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<bool> deleteAccount({
    required BuildContext context,
  }) async {
    final status = await _signInUseCase.deleteAccount(context: context);
    return status;
  }
}
