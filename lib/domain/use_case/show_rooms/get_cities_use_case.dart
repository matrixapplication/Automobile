import 'package:automobile_project/data/models/basic_model/basic_model.dart';

import 'package:automobile_project/domain/repository/show_rooms/show_rooms_repository.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class GetCitiesUseCase {
  final BaseShowRoomsRepository _baseShowRoomBranchesRepository;

  GetCitiesUseCase(this._baseShowRoomBranchesRepository);

  Future<ResponseModel<List<BasicModel>>?> call({
    required context,
  }) async {
    ApiResponse apiResponse = await _baseShowRoomBranchesRepository
        .getCities();
    print(apiResponse.response?.data);
    ResponseModel<List<BasicModel>>? responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<BasicModel> responseData = [];

        baseModel.data.forEach((object) => responseData.add(BasicModel.fromJson(object)));


        responseModel = ResponseModel<List<BasicModel>>(true, baseModel.message,
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
    print("mahmoud") ;
    print(responseModel.data);
    return responseModel;
  }
}
