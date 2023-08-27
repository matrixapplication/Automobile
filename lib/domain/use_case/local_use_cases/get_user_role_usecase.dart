import '../../../data/models/auth_model/auth_model.dart';
import '../../../data/models/base_response/response_model.dart';
import '../../logger.dart';
import '../../repository/local_repository/local_repo.dart';

class GetUserRoleUseCase {
  final _tag = 'GetUserDataUseCase';
  final LocalRepository repository;

  GetUserRoleUseCase({required this.repository});

  Future<ResponseModel> call() async {
    String? role = repository.getUserRole();

    if (role != null) {
      log(_tag, role.toString());
      return ResponseModel(true, 'successful getting user role', data: role);
    } else {
      return ResponseModel(false, 'error while fetching user role');
    }
  }
}
