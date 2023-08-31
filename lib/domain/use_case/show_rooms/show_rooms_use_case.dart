import 'package:automobile_project/core/resources/app_colors.dart';
import 'package:automobile_project/core/utils/alerts.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';
import '../../../data/models/auth_model/auth_model.dart';
import '../../repository/show_rooms/show_rooms_repository.dart';

class ShowRoomsUseCase {
  final BaseShowRoomsRepository _baseShowRoomsRepository;

  ShowRoomsUseCase(this._baseShowRoomsRepository);

  Future<ResponseModel<List<ShowRoomModel>>> call({
    required int page,
    required context,
  }) async {
    ApiResponse apiResponse =
        await _baseShowRoomsRepository.allShowRooms(page: page);
    ResponseModel<List<ShowRoomModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<ShowRoomModel> restaurantTypes = [];

        baseModel.data.forEach(
            (object) => restaurantTypes.add(ShowRoomModel.fromJson(object)));

        responseModel = ResponseModel<List<ShowRoomModel>>(
            true, baseModel.message,
            data: restaurantTypes, pagination: baseModel.pagination);
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
  Future<ResponseModel<List<ShowRoomModel>>> callAgency({
    required int page,
    required context,
  }) async {
    ApiResponse apiResponse =
    await _baseShowRoomsRepository.allAgencies(page: page);
    ResponseModel<List<ShowRoomModel>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<ShowRoomModel> restaurantTypes = [];

        baseModel.data.forEach(
                (object) => restaurantTypes.add(ShowRoomModel.fromJson(object)));

        responseModel = ResponseModel<List<ShowRoomModel>>(
            true, baseModel.message,
            data: restaurantTypes, pagination: baseModel.pagination);
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
