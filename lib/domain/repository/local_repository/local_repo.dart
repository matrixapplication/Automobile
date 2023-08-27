
import 'package:automobile_project/data/models/end_user/end_user_model.dart';

import '../../../data/models/auth_model/auth_model.dart';

abstract class LocalRepository {
  Future<bool> saveUserToken(String token);
  Future<bool> saveUserRole(String role);
  String? getUserRole();
  String getUserToken();
  Future<bool> saveUserData(ShowRoomModel userModel);
  Future<bool> saveEndUserData(EndUserModel userModel);
  ShowRoomModel? getUserData();
  EndUserModel? getEndUserData();
  bool isLoggedIn();
  Future<bool> clearSharedData();
}
