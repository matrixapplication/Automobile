import 'package:automobile_project/data/models/basic_model/basic_model.dart';

import 'package:automobile_project/domain/repository/drop_down/drop_down_repository.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';
import '../../../data/models/feature_model/feature_model.dart';

class CarFeaturesUseCase {
  final BaseDropDownsRepository _baseDropDownsRepository;

  CarFeaturesUseCase(this._baseDropDownsRepository);

  Future<ResponseModel<List<FeatureModel>>> call({
    required context,
  }) async {
    ApiResponse apiResponse = await _baseDropDownsRepository.carFeatures();
    ResponseModel<List<FeatureModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<FeatureModel> responseData = [];

        baseModel.data.forEach(
            (object) => responseData.add(FeatureModel.fromJson(object)));

        responseModel = ResponseModel<List<FeatureModel>>(
            true, baseModel.message,
            data: responseData);
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
