
import '../../../data/models/base_response/api_response.dart';

mixin AdminRepository {
  Future<ApiResponse> getAdminCars({
    required int page,
  });


}
