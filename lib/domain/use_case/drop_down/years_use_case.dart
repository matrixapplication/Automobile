import 'package:automobile_project/data/models/basic_model/basic_model.dart';

import 'package:automobile_project/domain/repository/drop_down/drop_down_repository.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class YearsUseCase {
  final BaseDropDownsRepository _baseDropDownsRepository;

  YearsUseCase(this._baseDropDownsRepository);

  Future<ResponseModel<List<int>>> call({
    required context,
  }) async {
    ApiResponse apiResponse = await _baseDropDownsRepository.years();
    ResponseModel<List<int>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<int> yearsList = [];

        baseModel.data.forEach((object) {
          yearsList.add(object);
        });
        responseModel =
            ResponseModel<List<int>>(true, baseModel.message, data: yearsList);
      }
      //200
      else {
        responseModel =
            ApiChecker.checkApi(context, message: baseModel.message);
      }
    } else {
      ErrorResponse baseModel =
          ErrorResponse.fromJson(apiResponse.response?.data);
      final message = baseModel.message;
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }
}
