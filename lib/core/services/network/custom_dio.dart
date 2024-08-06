import 'package:dio/dio.dart';

class CustomDio {
  final Dio _dio = Dio();

  CustomDio() {
    _dio.options.baseUrl = "https://automobile-egy.com/api/";
    _dio.options.connectTimeout = 5000;
  }
//cities
  Future get(
    String url,
      Map<String, dynamic> queryParameters,
  ) async {

    try {
      final response = await _dio.get(url,
          queryParameters: queryParameters,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ));
      return response.data;
    } on DioError catch (e) {
      print('Dio error $e');
      throw Exception(e.message);
    }
  }

  Future post(
    String url,
      {Map<String, dynamic>? data}
  ) async {
    print('url ${_dio.options.baseUrl + url}');
    print('data $data');
    try {
      final response = await _dio.post(url,
          data: data,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ));
      return response.data;
    } on DioError catch (e) {
      print('Dio error ${e.response?.data}');
      throw Exception(e.message);
    }
  }
}
