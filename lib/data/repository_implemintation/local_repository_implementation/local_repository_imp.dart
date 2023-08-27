import 'dart:convert';
import 'package:automobile_project/data/models/end_user/end_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/local/shared_preferences_keys.dart';
import '../../../domain/repository/local_repository/local_repo.dart';
import '../../data_sourse/remote/dio/dio_client.dart';
import '../../models/auth_model/auth_model.dart';


class LocalRepositoryImp implements LocalRepository {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  LocalRepositoryImp(
      {required this.sharedPreferences, required this.dioClient});

  @override
  Future<String?> saveDeviceToken() async {
    return null;

    // String? _deviceToken = await FirebaseMessaging.instance.getToken();
    // if (_deviceToken != null) {
    //   print('--------Device Token---------- '+_deviceToken);
    // }
    // return _deviceToken;
  }

  @override
  String getUserToken() {
    return sharedPreferences!.getString(SharedPreferencesKeys.kToken) ?? "";
  }

  @override
  bool isLoggedIn() {
    getUserToken() ;
    print('--------User Token---------- ${getUserToken()}');
    return sharedPreferences!.containsKey(SharedPreferencesKeys.kToken);
  }

  @override
  Future<bool> clearSharedData() async {
    dioClient!.token = '';
    dioClient!.dio!.options.headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Content-Language': /*appContext?.locale.languageCode ??*/ 'en',
      'Authorization': ''
    };
    return await sharedPreferences!.clear();
  }

  // for  user token
  @override
  Future<bool> saveUserToken(String token) async {
    dioClient!.token = token;
    dioClient!.dio!.options.headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Content-Language': /*appContext?.locale.languageCode ??*/ 'en',
      'Authorization': 'Bearer $token'
    };
    try {
      return await sharedPreferences!
          .setString(SharedPreferencesKeys.kToken, token);
    } catch (e) {
      return false;
    }
  }

  @override
  ShowRoomModel? getUserData()  {
    String? user =
        sharedPreferences!.getString(SharedPreferencesKeys.kUserData);
    return user != null ? ShowRoomModel.fromJson(jsonDecode(user)) : null;
  }

  @override
  String getUserRole() {
    return sharedPreferences!.getString(SharedPreferencesKeys.kRole) ?? "";
  }

  @override
  Future<bool> saveUserRole(String role) async{

    try {
      return await sharedPreferences!
          .setString(SharedPreferencesKeys.kRole, role);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> saveUserData(ShowRoomModel userModel) {
    String user = jsonEncode(userModel.toJson());

    return sharedPreferences!.setString(SharedPreferencesKeys.kUserData, user);
  }

  @override
  EndUserModel? getEndUserData() {
    // TODO: implement getEndUserData

    String? user =
    sharedPreferences!.getString(SharedPreferencesKeys.kUserData);
    return user != null ? EndUserModel.fromJson(jsonDecode(user)) : null;

  }

  @override
  Future<bool> saveEndUserData(EndUserModel userModel) {
    // TODO: implement saveEndUserData
    String user = jsonEncode(userModel.toJson());

    return sharedPreferences!.setString(SharedPreferencesKeys.kUserData, user);
  }

}
