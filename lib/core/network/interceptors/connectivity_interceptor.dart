import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:eventy/core/network/retry_manger.dart';

class ConnectivityInterceptor extends Interceptor {
  final Connectivity _connectivity = Connectivity();
  // to store failed requests
  final List<RequestOptions> _pendingRequests = [];

  final Dio dio;

  ConnectivityInterceptor(this.dio) {
    // Listen to connectivity changes
    _listenToConnectivityChanges();
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      // Store the request for later retry
      _pendingRequests.add(options);
      // Reject the request with a custom error message
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No internet',
          message: 'Please check your internet connection.',
        ),
      );
    }
    return handler.next(options);
  }

  void _listenToConnectivityChanges() {
    _connectivity.onConnectivityChanged.listen((result) {
      if (!result.contains(ConnectivityResult.none)) {
        //_retryPendingRequests(); // Retry pending requests when internet is back
        RetryManger.retryAll();
      }
    });
  }

  // void _retryPendingRequests() async {
  //   if (_pendingRequests.isEmpty) return;

  //   //final dio = Dio();
  //   for (var request in List.of(_pendingRequests)) {
  //     try {
  //       await _dio.fetch(request); // Retry the request
  //       _pendingRequests.remove(request); // Remove the request from the list
  //     } catch (e) {
  //       print("Failed to retry request, will try again later");
  //     }
  //   }
  // }
}
