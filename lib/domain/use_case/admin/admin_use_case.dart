import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/data/models/car_model/admin_car_model.dart';
import 'package:automobile_project/data/models/car_model/car_model.dart';
import 'package:automobile_project/domain/repository/admin/admin_repository.dart';
import 'package:automobile_project/domain/repository/fav_repository/fav_repository.dart';

import 'package:automobile_project/domain/repository/show_rooms/show_rooms_repository.dart';

import '../../../../core/exceptions/api_checker.dart';
import '../../../../data/models/base_response/api_response.dart';
import '../../../../data/models/base_response/base_model.dart';
import '../../../../data/models/base_response/error_response.dart';
import '../../../../data/models/base_response/response_model.dart';

class AdminUseCase {
  final AdminRepository _adminRepository;

  AdminUseCase(this._adminRepository);
  Future<ResponseModel<List<AdminCars>>> call({
    required int page,
    required context,
  }) async {
    ApiResponse apiResponse = await _adminRepository.getAdminCars(page: page);
    ResponseModel<List<AdminCars>> responseModel;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);

      if (baseModel.status == true) {
        List<AdminCars> agenciesLIst = [];

        baseModel.data.forEach(
                (object) => agenciesLIst.add(AdminCars.fromJson(object)));

        responseModel = ResponseModel<List<AdminCars>>(
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




