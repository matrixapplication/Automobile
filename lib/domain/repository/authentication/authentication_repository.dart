import 'dart:io';

import '../../../data/models/base_response/api_response.dart';

mixin BaseAuthenticationRepository {
  Future<ApiResponse> showRoomLogin({
    required String? code,
    required String? password,
  });

  Future<ApiResponse> logOut();
  Future<ApiResponse> getEndUser({required String token});
  Future<ApiResponse> getShowRoom();

  Future<ApiResponse> endUserLogin({
    required String? email,
    required String? password,
  });

  Future<ApiResponse> endUserRegister ({
  required String? name ,
    required String? email ,
    required String? phone ,
    required String? password ,
    required String? confirmPassword ,
    required String? image
}) ;


  Future<ApiResponse> endUserEditProfile ({
    required String? name ,
    required String? email ,
    required String? phone ,
    required String? password ,
    required String? confirmPassword ,
  }) ;

  Future<ApiResponse> endShowRoomEditProfile ({
    required String? name ,
    required String? showRoomName ,
    required String? code ,
    required String? phone ,
    required String? whatsApp ,
    required String? password ,
    required String? confirmPassword ,
    required String ? coverImage ,
  }) ;

  Future<ApiResponse> uploadImage({
  required File image
}) ;

  Future<ApiResponse> uploadShowRoomImage({
    required File image
  }) ;
}
