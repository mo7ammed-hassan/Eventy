// failures.dart
import 'package:eventy/core/errors/exceptions.dart';

abstract class Failure {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.code});

  factory ServerFailure.fromException(ServerException exception) {
    return ServerFailure(message: exception.message, code: exception.code);
  }
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
