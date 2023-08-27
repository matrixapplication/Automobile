import '../../../data/models/base_response/response_model.dart';
import '../../logger.dart';
import '../../repository/local_repository/local_repo.dart';

class SaveRoleDataUseCase {
  final _tag = 'SaveUserDataUseCase';
  final LocalRepository repository;

  SaveRoleDataUseCase({required this.repository});

  Future<ResponseModel> call({
    required String role,
    // required UserModel userModel,
  }) async {
    log(_tag, 'save role = $role ');
    bool isSaveToken = await repository.saveUserRole(role);
    // bool isSaveUser = await repository.saveUserData(userModel);

    if (isSaveToken) {
      log(_tag, 'save data successful');
      return ResponseModel(true, 'successful save token data');
    } else {
      return ResponseModel(false, 'error while saving user token');
    }
  }
}
