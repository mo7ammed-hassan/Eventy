import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String message;
  final int? code;

  ServerException(this.message, {this.code});

  factory ServerException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerException('Request timeout', code: 408);
      case DioExceptionType.badResponse:
        return ServerException(
          _extractErrorMessage(dioError.response) ?? 'Bad request',
          code: dioError.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ServerException('Request cancelled', code: 499);
      case DioExceptionType.connectionError:
        return ServerException('Connection error', code: 503);
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return ServerException('No internet connection', code: 502);
        }
        return ServerException('Unexpected error occurred', code: 500);
      default:
        return ServerException('Something went wrong', code: 500);
    }
  }

  static String? _extractErrorMessage(Response? response) {
    try {
      if (response?.data is Map) {
        return response?.data['message'] as String?;
      }
      if (response?.data is String) {
        return response?.data as String?;
      }
      return _getDefaultErrorMessage(response?.statusCode);
    } catch (e) {
      return _getDefaultErrorMessage(response?.statusCode);
    }
  }

  static String _getDefaultErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Resource not found';
      case 422:
        return 'Validation failed';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }
}
