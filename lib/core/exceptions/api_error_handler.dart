import 'package:automobile_project/core/exceptions/error_widget.dart';
import 'package:dio/dio.dart';

import '../../data/models/base_response/error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = const ErrorModel(
                  code: ErrorEnum.cancel, errorMessage: "noConnection");
              break;
            case DioErrorType.connectTimeout:
              errorDescription = const ErrorModel(
                  code: ErrorEnum.connectTimeout, errorMessage: "noConnection");
              break;
            case DioErrorType.receiveTimeout:
              errorDescription = const ErrorModel(
                  code: ErrorEnum.receiveTimeout, errorMessage: "noConnection");
              break;
            case DioErrorType.sendTimeout:
              errorDescription = const ErrorModel(
                  code: ErrorEnum.sendTimeout, errorMessage: "noConnection");
              break;
            case DioErrorType.other:
              errorDescription = const ErrorModel(
                  code: ErrorEnum.other, errorMessage: "noConnection");
              break;

            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 401:
                  errorDescription = const ErrorModel(
                      code: ErrorEnum.auth, errorMessage: 'Unauthorized');
                  break;
                case 404:
                case 500:
                case 503:
                  errorDescription = ErrorModel(
                      code: ErrorEnum.server,
                      errorMessage: error.response?.statusMessage ?? 'server');
                  break;
                default:
                  ErrorResponse errorResponse =
                      ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.message != null &&
                      errorResponse.message!.isNotEmpty) {
                    errorDescription = errorResponse;
                  } else {
                    errorDescription = ErrorModel(
                        code: ErrorEnum.otherError,
                        errorMessage:
                            "Failed to load data - status code: ${error.response!.statusCode}");
                  }
              }
              break;
          }
        } else {
          errorDescription = const ErrorModel(
              code: ErrorEnum.otherError,
              errorMessage: "Unexpected error occured");
        }
      } on FormatException catch (e) {
        errorDescription =
            ErrorModel(code: ErrorEnum.otherError, errorMessage: e.toString());
      } catch (e) {
        errorDescription =
            ErrorModel(code: ErrorEnum.otherError, errorMessage: e.toString());
      }
    } else {
      errorDescription = const ErrorModel(
          code: ErrorEnum.otherError,
          errorMessage: "is not a subtype of exception");
    }
    return errorDescription;
  }
}
