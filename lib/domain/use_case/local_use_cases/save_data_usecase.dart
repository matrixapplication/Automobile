import 'package:automobile_project/data/models/auth_model/auth_model.dart';
import 'package:automobile_project/data/models/end_user/end_user_model.dart';

import '../../../data/models/base_response/response_model.dart';
import '../../logger.dart';
import '../../repository/local_repository/local_repo.dart';

class SaveTokenDataUseCase {
  final _tag = 'SaveUserDataUseCase';
  final LocalRepository repository;

  SaveTokenDataUseCase({required this.repository});

  Future<ResponseModel> call({
    required String token,
    required ShowRoomModel userModel
  }) async {
    log(_tag, 'save token = $token }');
    bool isSaveToken = await repository.saveUserToken(token);
    bool isSaveUser = await repository.saveUserData(userModel);

    if (isSaveToken) {
      log(_tag, 'save data successful');
      return ResponseModel(true, 'successful save token data');
    } else {
      return ResponseModel(false, 'error while saving user token');
    }
  }

  Future<ResponseModel> callEndUser({
    required String token,
     required EndUserModel userModel,
  }) async {
    log(_tag, 'save token = $token }');
    bool isSaveToken = await repository.saveUserToken(token);
    bool isSaveUser = await repository.saveEndUserData(userModel);

    if (isSaveToken) {
      log(_tag, 'save data successful');
      return ResponseModel(true, 'successful save token data');
    } else {
      return ResponseModel(false, 'error while saving user token');
    }
  }
}
