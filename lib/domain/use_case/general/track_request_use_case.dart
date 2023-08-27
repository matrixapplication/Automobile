
import 'package:automobile_project/data/models/slider/slider_model.dart';
import 'package:automobile_project/data/models/track_request_model/track_request.dart';
import 'package:automobile_project/domain/repository/general/general_repositry.dart';
import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class TrackYourRequestUseCase {
  final GeneralRepository _generalRepository;

  TrackYourRequestUseCase(this._generalRepository);

  Future<ResponseModel<TrackRequestModel>> call({
    required context,
    required String phone
  }) async {
    ApiResponse apiResponse = await _generalRepository
        .trackUrRequest(phone: phone);
    ResponseModel<TrackRequestModel> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        TrackRequestModel responseData = TrackRequestModel.fromJson(baseModel.data) ;
        responseModel = ResponseModel<TrackRequestModel>(
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
