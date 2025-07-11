import 'dart:async';
import 'package:dio/dio.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/manager/logout_manager.dart';
import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/auth/data/datasources/auth_remote_datasource.dart';


class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final SecureStorage _storage = getIt.get<SecureStorage>();

  AuthInterceptor(this._dio);

  bool _isRefreshing = false;
  final List<Function()> _retryQueue = [];

  bool _isLogoutRequest(DioException err) {
    return err.requestOptions.path.contains('/logout');
  }

  Future<void> _lockAndRefreshToken() async {
    if (_isRefreshing) {
      // ⏳ لو في refresh شغّال، انتظر يخلص
      final completer = Completer<void>();
      _retryQueue.add(() => completer.complete());
      return completer.future;
    }

    _isRefreshing = true;
    try {
      final newToken = await _refreshToken();
      if (newToken != null) {
        await _storage.saveToken(key: 'access_token', value: newToken);
        for (var retry in _retryQueue) {
          retry();
        }
        _retryQueue.clear();
      } else {
        throw Exception('Unable to refresh token');
      }
    } finally {
      _isRefreshing = false;
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && !_isLogoutRequest(err)) {
      final requestOptions = err.requestOptions;

      try {
        await _lockAndRefreshToken();
        final newToken = await _storage.getAccessToken();

        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final response = await _dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (_) {
        _logout();
        return handler.reject(err);
      }
    }

    return handler.next(err);
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await _storage.read(key: 'refresh_token');
      final response = await ApiClient().dio.post(
        'https://eventplanner-productionce6e.up.railway.app/api/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['data']['accessToken'];
        final newRefreshToken =
            response.data['data']['refreshToken'] ?? newAccessToken;

        await _storage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        return newAccessToken;
      }
    } catch (_) {
      // ignore
    }

    return null;
  }

  void _logout() {
    getIt<AuthRemoteDataSource>().logout();
    LogoutManager.forceLogout();
  }
}


// class AuthInterceptor extends Interceptor {
//   final SecureStorage _storage = getIt.get<SecureStorage>();
//   final Dio _dio;

//   AuthInterceptor(this._dio);

//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final token = await _storage.getAccessToken();
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     return handler.next(options);
//   }

//   @override
//   Future<void> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     if (err.response?.statusCode == 401) {
//       // Skip refresh if it's a logout request
//       if (err.requestOptions.path.contains('/logout')) {
//         return handler.next(err);
//       }

//       String? newAccessToken = await _refreshToken();
//       if (newAccessToken != null) {
//         await _storage.saveToken(key: 'access_token', value: newAccessToken);
//         err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

//         final cloneReq = await _dio.request(
//           err.requestOptions.path,
//           options: Options(
//             method: err.requestOptions.method,
//             headers: err.requestOptions.headers,
//           ),
//           data: err.requestOptions.data,
//           queryParameters: err.requestOptions.queryParameters,
//         );

//         return handler.resolve(cloneReq);
//       } else {
//         _logout();
//         return handler.reject(err);
//       }
//     } else {
//       return handler.next(err);
//     }
//   }

//   Future<String?> _refreshToken() async {
//     try {
//       String? refreshToken = await _storage.read(key: 'refresh_token');

//       final response = await ApiClient().dio.post(
//         'https://eventplanner-productionce6e.up.railway.app/api/auth/refresh',
//         data: {'refreshToken': refreshToken},
//       );

//       if (response.statusCode == 200) {
//         await _storage.saveTokens(
//           accessToken: response.data['data']['accessToken'],
//           refreshToken:
//               response.data['data']['refreshToken'] ??
//               response.data['data']['accessToken'],
//         );
//         return response.data['data']['accessToken'];
//       } else {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   void _logout() {
//     getIt<AuthRemoteDataSource>().logout();
//     LogoutManager.forceLogout();
//   }
// }
