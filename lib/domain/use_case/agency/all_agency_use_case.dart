import 'package:automobile_project/domain/repository/agency/agency_repository.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';
import '../../../data/models/auth_model/auth_model.dart';

class AllAgencyUseCase {
  final BaseAgencyRepository _baseAgencyRepository;

  AllAgencyUseCase(this._baseAgencyRepository);

  Future<ResponseModel<List<ShowRoomModel>>> call({
    required int page,
    required context,
  }) async {
    ApiResponse apiResponse = await _baseAgencyRepository.allAgency(page: page);
    ResponseModel<List<ShowRoomModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<ShowRoomModel> agenciesLIst = [];

        baseModel.data.forEach(
            (object) => agenciesLIst.add(ShowRoomModel.fromJson(object)));

        responseModel = ResponseModel<List<ShowRoomModel>>(
            true, baseModel.message,
            data: agenciesLIst, pagination: baseModel.pagination);
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
