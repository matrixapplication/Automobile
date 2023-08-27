import 'package:automobile_project/data/models/end_user/end_user_model.dart';

import '../../../data/models/auth_model/auth_model.dart';
import '../../../data/models/base_response/response_model.dart';
import '../../logger.dart';
import '../../repository/local_repository/local_repo.dart';

class GetUserDataUseCase {
  final _tag = 'GetUserDataUseCase';
  final LocalRepository repository;

  GetUserDataUseCase({required this.repository});

  Future<ResponseModel> call() async {
    ShowRoomModel? userModel = repository.getUserData();

    if (userModel != null) {
      log(_tag, userModel.role??"");
      return ResponseModel(true, 'successful getting user data',
          data: userModel);
    } else {
      return ResponseModel(false, 'error while fetching user data');
    }
  }
  Future<ResponseModel> callEndUser() async {
    EndUserModel? userModel = repository.getEndUserData();

    if (userModel != null) {
      log(_tag, userModel.role??"");
      return ResponseModel(true, 'successful getting user data',
          data: userModel);
    } else {
      return ResponseModel(false, 'error while fetching user data');
    }
  }
}
