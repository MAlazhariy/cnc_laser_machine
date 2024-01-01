
// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:elaser/data/model/base/error_response_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Handling the error here and return a final result of error and parse to
/// final responseModel.error
class ApiErrorHandler {
  static ErrorResponse handle(dynamic error){
    debugPrint('error handler');
    debugPrint('- error type: ${error.runtimeType}');
    debugPrint('- error: $error');

    if (error is Response) {
      ErrorResponse? errorResponse;
      try {
        errorResponse = ErrorResponse.fromJson(
          error.data,
          code: error.statusCode,
          // message: error.response?.statusMessage,
        );

      } catch(e){}
      debugPrint('--- error data: ${error.data}');
      debugPrint('--- error message: ${error.statusMessage}');

      if (errorResponse == null) {
        return ErrorResponse("${error.statusCode}: ${"error_occurred".tr()}");
      } else {
        return errorResponse;
      }
    } else if (error is! Exception){
      return ErrorResponse("$error");
    }

    try{
      if(error is! DioException){
        return ErrorResponse("$error");
      }

      switch (error.type){
        case DioExceptionType.connectionTimeout:
          return ErrorResponse("connection_timeout_error".tr());
        case DioExceptionType.sendTimeout:
          return ErrorResponse("send_timeout_error".tr());
        case DioExceptionType.receiveTimeout:
          return ErrorResponse("receive_timeout_error".tr());
        case DioExceptionType.cancel:
          return ErrorResponse("error_request_canceled".tr());
        case DioExceptionType.connectionError:
          return ErrorResponse("connection_to_server_failed".tr());
        case DioExceptionType.badCertificate:
          return ErrorResponse("bad_certificate_error".tr());
        case DioExceptionType.unknown:
          return ErrorResponse("unexpected_error_occurred".tr());

        case DioExceptionType.badResponse:
          switch (error.response!.statusCode){
            case 404:
            case 500:
            case 503:
              return ErrorResponse("${error.response!.statusCode}: ${error.response!.statusMessage??"error_occurred".tr()}");

            default:
              ErrorResponse? errorResponse;
              try {
                errorResponse = ErrorResponse.fromJson(
                  error.response?.data,
                  code: error.response?.statusCode,
                  // message: error.response?.statusMessage,
                );

              } catch(e){}
                debugPrint('--- error data: ${error.response?.data}');
                debugPrint('--- error message: ${error.response?.statusMessage}');

              if (errorResponse == null) {
                return ErrorResponse("${error.response?.statusCode}: ${"error_occurred".tr()}");
              } else {
                return errorResponse;
              }
          }
      }
    } on FormatException catch (e){
      return ErrorResponse("${"error_occurred".tr()}: $e");
    }
  }
}