
import '../../../data/models/base_response/api_response.dart';

mixin FavRepository {
  Future<ApiResponse> addRemoveFav({
    required int carId,
  });

  Future<ApiResponse> showFav();

}
