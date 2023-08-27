import 'package:automobile_project/data/models/basic_model/basic_model.dart';

import 'package:automobile_project/domain/repository/drop_down/drop_down_repository.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class CarColorsUseCase {
  final BaseDropDownsRepository _baseDropDownsRepository;

  CarColorsUseCase(this._baseDropDownsRepository);

  Future<ResponseModel<List<BasicModel>>> call({
    required context,
  }) async {
    ApiResponse apiResponse = await _baseDropDownsRepository.carColors();
    ResponseModel<List<BasicModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<BasicModel> restaurantTypes = [];

        baseModel.data.forEach((object) => restaurantTypes.add(BasicModel.fromJson(object)));

        responseModel = ResponseModel<List<BasicModel>>(true, baseModel.message,
            data: restaurantTypes);
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
