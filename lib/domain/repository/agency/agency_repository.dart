import '../../../data/models/base_response/api_response.dart';

mixin BaseAgencyRepository {
  Future<ApiResponse> allAgency({
    required int page,
  });
}
