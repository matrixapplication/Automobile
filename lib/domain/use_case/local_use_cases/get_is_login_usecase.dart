import '../../../data/models/base_response/response_model.dart';
import '../../logger.dart';
import '../../repository/local_repository/local_repo.dart';

class GetIsUserLoginUseCase {
  final _tag = 'GetIsUserLoginUseCase';
  final LocalRepository repository;

  GetIsUserLoginUseCase({required this.repository});

  Future<ResponseModel> call() async {
    bool isLogin = repository.isLoggedIn();

    if (isLogin) {
      log(_tag, 'is user');
      return ResponseModel(true, 'user is login');
    } else {
      return ResponseModel(false, 'error while check if user is login');
    }
  }
}
