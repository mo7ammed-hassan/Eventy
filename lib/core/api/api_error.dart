import 'package:dio/dio.dart';

abstract class ApiError implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  const ApiError(this.message, {this.statusCode, this.details});

  @override
  // String toString() =>
  //     'ApiError: $message (Status: $statusCode, Details: $details)';
  String toString() => message;
}

// Specific Error Types
class NetworkError extends ApiError {
  const NetworkError(super.message, {super.details});
}

class ServerError extends ApiError {
  const ServerError(super.message, {super.statusCode, super.details});
}

class CacheError extends ApiError {
  const CacheError(super.message, {super.details});
}

class ValidationError extends ApiError {
  const ValidationError(super.message, {super.details});
}

// Error Handler Class
class ErrorHandler {
  static ApiError handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is ApiError) {
      return error;
    } else {
      return NetworkError('Unknown error occurred', details: error.toString());
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

      case DioExceptionType.badResponse:
        return _parseServerError(error.response);

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return const NetworkError('No internet connection');
    }
  }

  static ApiError _parseServerError(Response? response) {
    if (response == null) {
      return const ServerError('No response from server');
    }

    final int? code = response.statusCode;
    final dynamic data = response.data;

    String message = 'Server error';

    if (data is Map<String, dynamic>) {
      if (data.containsKey('message')) {
        message = data['message'];
      } else if (data.containsKey('errors') && data['errors'] is List) {
        message = (data['errors'] as List).join(", ");
      }
    }

    switch (code) {
      case 400:
        return ValidationError(message, details: data);
      case 404:
        if (response.data is Map<String, dynamic> &&
            response.data.containsKey('message')) {
          return ValidationError(message, details: data);
        }
        return NetworkError('Resource not found', details: data);
      case 401:
        return NetworkError('Unauthorized', details: data);
      case 403:
        return NetworkError('Forbidden', details: data);
      case 500:
        return ServerError('Internal server error',
            statusCode: code, details: data);
      default:
        return ServerError(message, statusCode: code, details: data);
    }
  }
}
