import 'package:automobile_project/data/models/end_user/end_user_model.dart';

import '../../../data/models/auth_model/auth_model.dart';
import '../../../data/models/base_response/response_model.dart';
import '../../logger.dart';
import '../../repository/local_repository/local_repo.dart';

class SaveUserDataUseCase {
  final _tag = 'SaveUserDataUseCase';
  final LocalRepository repository;

  SaveUserDataUseCase({required this.repository});

  Future<ResponseModel> call({
    required ShowRoomModel userModel,
    // required UserModel userModel,
  }) async {
    // log(_tag, 'save email = ${userModel.email} }');
    bool isSaveToken = await repository.saveUserData(userModel);
    repository.getUserData();
    // bool isSaveUser = await repository.saveUserData(userModel);
    if (isSaveToken) {
      log(_tag, 'save data successful');
      return ResponseModel(true, 'successful saving user data successful ');
    } else {
      return ResponseModel(false, 'error while saving user data');
    }
  }


  Future<ResponseModel> callEndUser({
    required EndUserModel userModel,
    // required UserModel userModel,
  }) async {
    // log(_tag, 'save email = ${userModel.email} }');
    bool isSaveToken = await repository.saveEndUserData(userModel);
    repository.getEndUserData();
    // bool isSaveUser = await repository.saveUserData(userModel);


    if (isSaveToken) {
      log(_tag, 'save data successful');
      return ResponseModel(true, 'successful saving user data successful ');
    } else {
      return ResponseModel(false, 'error while saving user data');
    }
  }
}
