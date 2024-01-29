import 'package:automobile_project/config/navigation/navigation_services.dart';
import 'package:automobile_project/config/navigation/routes.dart';
import 'package:automobile_project/core/services/local/shared_preferences_keys.dart';
import 'package:automobile_project/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../domain/use_case/local_use_cases/clear_user_data_usecase.dart';
import '../../domain/use_case/local_use_cases/get_is_login_usecase.dart';
import '../../domain/use_case/local_use_cases/get_user_data_usecase.dart';
import '../../domain/use_case/local_use_cases/get_user_role_usecase.dart';
import '../models/auth_model/auth_model.dart';
import '../models/base_response/response_model.dart';
import '../models/end_user/end_user_model.dart';

class LocalAuthProvider with ChangeNotifier {
  bool _isLogin = false;

  //TODO remove this value
  ShowRoomModel? _user;
  EndUserModel ? _endUser ;

  final GetIsUserLoginUseCase getIsUserLoginUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  final GetUserRoleUseCase getUserRoleUseCase;
  final ClearUserDataUseCase clearUserDataUseCase;

  LocalAuthProvider({
    required this.getIsUserLoginUseCase,
    required this.getUserDataUseCase,
    required this.getUserRoleUseCase,
    required this.clearUserDataUseCase,
  });

  ShowRoomModel? get user => _user;
  EndUserModel? get endUser => _endUser;
  String? _role;

  String? get role => _role;


  bool _isFirstTime = false ;


   bool get isFistTie => _isFirstTime ;

  checkFirstTime(){
    bool? check = shared?.getBool(SharedPreferencesKeys.kFirstTime) ;

    if(check != null){
      _isFirstTime = false ;
      shared!.setBool(SharedPreferencesKeys.kFirstTime, false);
    }else{
      _isFirstTime = true ;
      shared!.setBool(SharedPreferencesKeys.kFirstTime, true);
    }
    notifyListeners() ;
    return _isFirstTime ;
  }
  bool get isAuth => _isLogin;

  Future<bool> isLogin() async {
    ResponseModel responseModel = await getIsUserLoginUseCase.call();
    if (kDebugMode) {
      print("response model is Login =?? ${responseModel.isSuccess}");
    }
    if (responseModel.isSuccess) {
      _isLogin = true;
      if(_role == "showroom" || _role == "agency"){
        await getUserData();
      }else{
         await getEndUserData() ;
      }
    } else {
      _isLogin = false;
    }
    notifyListeners();
    return responseModel.isSuccess;
  }

  Future<ShowRoomModel?> getUserData() async {
    ResponseModel responseModel = await getUserDataUseCase.call();
    if (responseModel.isSuccess) {
      notifyListeners();

      _user = responseModel.data;
    }
    notifyListeners() ;
    return _user;
  }
  Future<EndUserModel?> getEndUserData() async {
    ResponseModel responseModel = await getUserDataUseCase.callEndUser();
    if (responseModel.isSuccess) {
      notifyListeners();
      _endUser = responseModel.data;
    }
    notifyListeners();
    return _endUser;
  }

  isFirstTime(){
    bool check = shared?.getBool(SharedPreferencesKeys.isFirstTime)  ?? false;
    if(check){
      notifyListeners();
     return check;
    }else{
      logOutForFCM();
     shared!.setBool(SharedPreferencesKeys.isFirstTime, true);
      notifyListeners() ;
      print("isFirstTime $check");
      return check;
    }
  }




  Future<String?> getUserRole() async {
    ResponseModel responseModel = await getUserRoleUseCase.call();
    if (responseModel.isSuccess) {
      _role = responseModel.data.toString();
      notifyListeners();
      return responseModel.data.toString();
    }
    notifyListeners();

    return null;
  }



  Future logOut({
    required BuildContext context,
  }) async {
    _user = null ;
    _endUser = null ;
    _role = null ;
    _isLogin = false ;
    clearUserDataUseCase.call() ;
    NavigationService.pushReplacementAll(context, Routes.loginScreen) ;
    notifyListeners();
  }

  Future logOutForFCM() async {
    _user = null ;
    _endUser = null ;
    _role = null ;
    _isLogin = false ;
    clearUserDataUseCase.call() ;
    notifyListeners();
  }
}
