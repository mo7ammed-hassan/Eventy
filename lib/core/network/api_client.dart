// # Create a singleton ApiClient to manage the Dio instance and interceptors.
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eventy/core/errors/error_handler.dart';
import 'package:eventy/core/network/interceptors/auth_interceptor.dart';
import 'package:eventy/core/network/interceptors/connectivity_interceptor.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late Dio dio;

  // Callback for logout
  VoidCallback? onLogout;

  // Get Base URL with HTTPS validation
  String baseUrl(String key) {
    try {
      final url = dotenv.get(key);
      // Validate HTTPS URLs
      if (!url.startsWith('https://')) {
        throw Exception('Invalid HTTPS URL in .env: $key');
      }
      return url;
    } catch (e) {
      throw Exception('Dotenv key not found: $key');
    }
  }

  String get baseUrlLink => baseUrl('BASE_URL');

  ApiClient._internal() {
    // Initialize Dio with security settings
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrlLink,
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // Add interceptors
    dio.interceptors.addAll([
      // Connectivity interceptor
      ConnectivityInterceptor(dio),
      // Auth interceptor
      AuthInterceptor(dio),
      // Retry interceptor
      _retryInterceptor(),

      // Log interceptor
      LogInterceptor(
        responseBody: kDebugMode,
        request: kDebugMode,
        error: kDebugMode,
        requestHeader: kDebugMode,
      ),
    ]);
  }

  // Retry Interceptor
  Interceptor _retryInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        if (_shouldRetry(error)) {
          await Future.delayed(const Duration(seconds: 1));
          try {
            return handler.resolve(await dio.fetch(error.requestOptions));
          } catch (e) {
            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    );
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.response?.statusCode == 502;
  }

  // Method to make API requests
  Future<Response> request({
    required String path,
    String? baseUrl,
    Object? data,
    Map<String, dynamic>? queryParameters,
    String method = 'GET',
    Map<String, dynamic>? headers,
    ValidateStatus? validateStatus,
  }) async {
    try {
      dio.options.baseUrl = baseUrl ?? baseUrlLink;
      final response = await dio.request(
        path,
        data: data,
        options: Options(
          method: method,
          headers: headers,
          validateStatus: validateStatus,
        ),
        queryParameters: queryParameters,
      );

      return response;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
