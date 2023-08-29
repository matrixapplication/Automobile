import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/utils/alerts.dart';
import 'package:automobile_project/data/models/basic_model/basic_model.dart';

import 'package:automobile_project/domain/repository/drop_down/drop_down_repository.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class CarStatusUseCase {
  final BaseDropDownsRepository _baseDropDownsRepository;

  CarStatusUseCase(this._baseDropDownsRepository);

  Future<ResponseModel<List<BasicModel>>> call({
    required context,
  }) async {
    ApiResponse apiResponse = await _baseDropDownsRepository.carStatus();
    ResponseModel<List<BasicModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<BasicModel> responseData = [];

        baseModel.data
            .forEach((object) => responseData.add(BasicModel.fromJson(object)));

        responseModel = ResponseModel<List<BasicModel>>(true, baseModel.message,
            data: responseData);
      }
      //200
      else {
        responseModel =
            ApiChecker.checkApi(context, message: baseModel.message);
      }
    } else {
      Alerts.showAppDialog(context,
          alertTitle: "Poor connection",
          alertDescription: " please check your connection and restart the app",
          onConfirm: () {},
          confirmText: "ok",
          withClose: false,
          confirmTextColor: ColorManager.white);
      ErrorResponse baseModel =
          ErrorResponse.fromJson(apiResponse.response?.data);
      final message = baseModel.message;
      responseModel = ApiChecker.checkApi(context, message: message);
    }
    return responseModel;
  }
}
