import 'package:dio/dio.dart';
import 'package:elaser/data/data_source/remote/exception/api_error_handler.dart';
import 'package:elaser/data/model/base/error_response_model.dart';

class ApiResponse {
  final Response? _response;
  final ErrorResponse? _error;

  Response? get response => _response;
  ErrorResponse? get error => _error;
  bool get isSuccess => _response != null;

  ApiResponse.withSuccess(Response response)
      : _response = response,
        _error = null;

  ApiResponse.withError(ErrorResponse errorValue)
      : _response = null,
        _error = errorValue;

  ApiResponse.fromResponse(Response response)
      : _response = response.statusCode == 200 ? response : null,
        _error = response.statusCode == 200 ? null : ApiErrorHandler.handle(response.data['message']??response.statusMessage);
}
