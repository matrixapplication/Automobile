// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:automobile_project/config/navigation/navigation.dart';
import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:automobile_project/data/models/end_user/end_user_model.dart';
import 'package:automobile_project/domain/use_case/authentication_use_case/end_user_use_case.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/get_user_data_usecase.dart';
import 'package:automobile_project/domain/use_case/local_use_cases/save_role_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/base_response/response_model.dart';
import '../../../../domain/use_case/authentication_use_case/show_room_login_use_case.dart';
import '../../../../domain/use_case/local_use_cases/save_data_usecase.dart';
import '../../../../domain/use_case/local_use_cases/save_user_usecase.dart';

class EndUserViewModel extends ChangeNotifier {
  final EndUserLoginUseCase _signInUseCase;
  final SaveTokenDataUseCase _saveUserTokenUseCase;
  final SaveRoleDataUseCase _saveRoleUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;
  final GetUserDataUseCase _getUserDataUseCase ;
  EndUserViewModel(
      { required EndUserLoginUseCase loginUseCase,
        required SaveTokenDataUseCase saveUserTokenUseCase,
        required SaveRoleDataUseCase saveRoleUseCase,
        required SaveUserDataUseCase saveUserDataUseCase ,
        required GetUserDataUseCase getUserDataUseCase ,
      })
      : _signInUseCase = loginUseCase,
        _saveUserTokenUseCase = saveUserTokenUseCase,
        _saveRoleUseCase = saveRoleUseCase,
        _saveUserDataUseCase = saveUserDataUseCase,
        _getUserDataUseCase  = getUserDataUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  EndUserModel? _endUserModel ;
  EndUserModel? get  endUserModel {
    return _endUserModel ;
  }
  Future<ResponseModel<EndUserModel>> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _signInUseCase.call(
      context: context,
      password: password,
      email: email,
    );
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      String? token = responseModel.data!.token.toString();
      String? role = responseModel.data!.role.toString();
      if(kDebugMode){
        print("success view Model token $token");
        print("success view Model role $role");
        print("success view Model data ${responseModel.data}");
      }
       _saveUserTokenUseCase.callEndUser(token: token , userModel: responseModel.data!);
      _saveRoleUseCase.call(role: role);
       _saveUserDataUseCase.callEndUser(userModel: responseModel.data!);

        await _getUserDataUseCase.callEndUser() ;

    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel<EndUserModel>> getEndUserData({
    required BuildContext context,
    required String token
  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _signInUseCase.getEndUser(
      context: context,
      token: token

    );
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      String? role = responseModel.data!.role.toString();
      if(kDebugMode){
        print("success view Model role $role");
        print("success view Model data ${responseModel.data}");
      }
      _saveRoleUseCase.call(role: role);
      _saveUserDataUseCase.callEndUser(userModel: responseModel.data!);
      await _getUserDataUseCase.callEndUser() ;


    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ResponseModel<EndUserModel>> register({
    required BuildContext context,
    required String name ,
    required String email ,
    required String phone ,
    required String password  ,
    required String confirmPassword ,
    required String countryId ,
  }) async {
    _isLoading = true;
    notifyListeners();
    final responseModel = await _signInUseCase.registerCall(
      context: context,
      name:  name ,
      phone: phone ,
      password: password ,
      email: email ,
      confirmPassword: confirmPassword,
      countryId: countryId
    );
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      String? role = responseModel.data!.role.toString();
      if(kDebugMode){
        print("success view Model role $role");
        print("success view Model data ${responseModel.data}");
      }
      _saveUserTokenUseCase.callEndUser(token: responseModel.data!.token! , userModel: responseModel.data!);
      _saveRoleUseCase.call(role: role);
      _saveUserDataUseCase.callEndUser(userModel: responseModel.data!);
      await _getUserDataUseCase.callEndUser() ;
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }



  Future<ResponseModel<EndUserModel>> editProfileEndUser({
    required BuildContext context,
    required String name ,
    required String email ,
    required String phone ,
    required String password  ,
    required String confirmPassword ,
  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _signInUseCase.editEndUserCall(
        context: context,
        name:  name ,
        phone: phone ,
        password: password ,
        email: email ,
        confirmPassword: confirmPassword
    );
    if (kDebugMode) {
      print(responseModel.data);
    }
    if (responseModel.isSuccess) {
      String? role = responseModel.data!.role.toString();
      if(kDebugMode){
        print("success view Model role $role");
        print("success view Model data ${responseModel.data}");
      }
      _saveRoleUseCase.call(role: role);
      _saveUserDataUseCase.callEndUser(userModel: responseModel.data!);
      await _getUserDataUseCase.callEndUser() ;
    } else {
      if (kDebugMode) {
        print("Fail view Model ${responseModel.message}");
      }
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }



  Future<ResponseModel<EndUserModel>> userUploadImage({
    required BuildContext context,
    required File image ,

  }) async {
    _isLoading = true;
    notifyListeners();

    final responseModel = await _signInUseCase.userImageUpload(context: context, image: image);
    if (kDebugMode) {
      print(responseModel.message);
    }
    if (responseModel.isSuccess) {
      String? role = responseModel.data!.role.toString();
      if(kDebugMode){
        print("success view Model role $role");
        print("success view Model data ${responseModel.data}");
      }
      _endUserModel = responseModel.data! ;
      _saveRoleUseCase.call(role: role);
      _saveUserDataUseCase.callEndUser(userModel: responseModel.data!);
      await _getUserDataUseCase.callEndUser() ;
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
