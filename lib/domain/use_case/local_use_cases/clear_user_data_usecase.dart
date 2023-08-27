import '../../../data/models/base_response/response_model.dart';
import '../../logger.dart';
import '../../repository/local_repository/local_repo.dart';

class ClearUserDataUseCase {
  final _tag = 'UserSubCategoriesViewModel';
  final LocalRepository repository;

  ClearUserDataUseCase({required this.repository});

  Future<ResponseModel> call() async {
    bool isCleared = await repository.clearSharedData();
    if (isCleared) {
      log(_tag, 'clear data successful');
      return ResponseModel(true, 'cleared cashed data');
    } else {
      return ResponseModel(false, 'error while cleared cashed data');
    }
  }
}
