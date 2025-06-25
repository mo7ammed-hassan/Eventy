import 'package:dio/dio.dart';
import 'package:eventy/core/errors/api_error.dart';

class ErrorHandler {
  static ApiError handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is ApiError) {
      return error;
    } else {
      return NetworkError('Unexpected error', details: error.toString());
    }
  }

  static ApiError _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkError('Connection timeout');

      case DioExceptionType.badCertificate:
        return const NetworkError('Bad SSL Certificate');

      case DioExceptionType.cancel:
        return const NetworkError('Request cancelled');

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return const NetworkError('No internet connection');

      case DioExceptionType.badResponse:
        return _parseServerError(error.response);
    }
  }

  static ApiError _parseServerError(Response? response) {
    if (response == null) {
      return const ServerError('No response from server');
    }

    final data = response.data;
    String message = 'Server error';

    if (data is Map<String, dynamic>) {
      message =
          data['message'] ??
          data['error_description'] ??
          data['error'] ??
          message;
    }

    switch (response.statusCode) {
      case 400:
        return ValidationError(message, statusCode: 400, details: data);
      case 401:
        return NetworkError('Unauthorized', statusCode: 401, details: data);
      case 403:
        return NetworkError('Forbidden', statusCode: 403, details: data);
      case 404:
        return NetworkError('Not found', statusCode: 404, details: data);
      case 500:
        return ServerError(
          'Internal server error',
          statusCode: 500,
          details: data,
        );
      default:
        return ServerError(
          message,
          statusCode: response.statusCode,
          details: data,
        );
    }
  }
}
