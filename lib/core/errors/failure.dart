import 'package:eventy/core/errors/api_error.dart';

abstract class Failure {
  final String message;
  final int? code;
  const Failure({required this.message, this.code});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  ValidationFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, super.code});
}

Failure mapErrorToFailure(ApiError error) {
  if (error is ValidationError) {
    return ValidationFailure(message: error.message, code: error.statusCode);
  } else if (error is NetworkError) {
    return NetworkFailure(message: error.message, code: error.statusCode);
  } else if (error is CacheError) {
    return CacheFailure(message: error.message, code: error.statusCode);
  } else {
    return ServerFailure(message: error.message, code: error.statusCode);
  }
}
