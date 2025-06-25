abstract class ApiError implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  const ApiError(this.message, {this.statusCode, this.details});

  @override
  String toString() => message;
}

class NetworkError extends ApiError {
  const NetworkError(super.message, {super.statusCode, super.details});
}

class ServerError extends ApiError {
  const ServerError(super.message, {super.statusCode, super.details});
}

class ValidationError extends ApiError {
  const ValidationError(super.message, {super.statusCode, super.details});
}

class CacheError extends ApiError {
  const CacheError(super.message, {super.statusCode, super.details});
}
