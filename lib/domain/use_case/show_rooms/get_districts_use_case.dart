import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/feature_model/feature_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';
import 'package:automobile_project/data/models/show_room_branch_model/show_room_branch_model.dart';

import 'package:automobile_project/domain/repository/drop_down/drop_down_repository.dart';
import 'package:automobile_project/domain/repository/show_rooms/show_rooms_repository.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class GetDistrictsUseCase {
  final BaseShowRoomsRepository _baseShowRoomBranchesRepository;

  GetDistrictsUseCase(this._baseShowRoomBranchesRepository);

  Future<ResponseModel<List<BasicModel>>?> call({
    required context,
    required id
  }) async {
    ApiResponse apiResponse = await _baseShowRoomBranchesRepository
        .getDistricts(id: id);
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
