import '../../../data/models/base_response/api_response.dart';

mixin BaseDropDownsRepository {
  Future<ApiResponse> brands();

  Future<ApiResponse> brandsModels({required int brandId});

  Future<ApiResponse> brandModelExtensions({required int id});

  Future<ApiResponse> years();

  Future<ApiResponse> mechanicalType();

  Future<ApiResponse> bodyShapeType();
  Future<ApiResponse> fuelType();
  Future<ApiResponse> carStatus();
  Future<ApiResponse> carFeatures();
  Future<ApiResponse> carColors();
}
