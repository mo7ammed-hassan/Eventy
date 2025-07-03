import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:flutter/foundation.dart';

mixin RetryMixin {
  Future<T?> retry<T>(
    Future<T> Function() task, {
    int maxRetries = 3,
    Duration delayBetweenRetries = const Duration(milliseconds: 500),
    bool Function(Object error)? shouldRetryOnError,
  }) async {
    int attempt = 0;
    while (attempt < maxRetries) {
      try {
        debugPrint('[retry] Attempt ${attempt + 1}');
        return await task();
      } catch (error) {
        attempt++;
        final shouldRetry = shouldRetryOnError?.call(error) ?? true;

        debugPrint('[retry] Error: $error');
        debugPrint('[retry] Should retry: $shouldRetry');

        if (attempt >= maxRetries || !shouldRetry) {
          debugPrint('[retry] Giving up after $attempt attempts.');
          rethrow;
        }

        await Future.delayed(delayBetweenRetries);
      }
    }
    return null;
  }

  Future<Either<Failure, T>> retryEither<T>(
    Future<Either<Failure, T>> Function() task, {
    int maxRetries = 3,
    Duration delayBetweenRetries = const Duration(milliseconds: 500),
    bool Function(Failure failure)? shouldRetryOnFailure,
  }) async {
    int attempt = 0;
    while (attempt < maxRetries) {
      debugPrint('[retryEither] Attempt ${attempt + 1}');
      final result = await task();

      if (result.isRight()) return result;

      final failure = result.fold((l) => l, (_) => throw UnimplementedError());
      final shouldRetry = shouldRetryOnFailure?.call(failure) ?? true;

      debugPrint('[retryEither] Failure: $failure');
      debugPrint('[retryEither] Should retry: $shouldRetry');

      attempt++;

      if (attempt >= maxRetries || !shouldRetry) {
        debugPrint('[retryEither] Giving up after $attempt attempts.');
        return result;
      }

      await Future.delayed(delayBetweenRetries);
    }

    return const Left(UnknownFailure(message: 'Retry failed'));
  }

  Future<Either<Failure, Unit>> retryEitherUnit(
    Future<Either<Failure, Unit>> Function() task, {
    int maxRetries = 3,
    Duration delayBetweenRetries = const Duration(milliseconds: 500),
    bool Function(Failure failure)? shouldRetryOnFailure,
  }) async {
    int attempt = 0;
    while (attempt < maxRetries) {
      debugPrint('[retryEitherUnit] Attempt ${attempt + 1}');
      final result = await task();

      if (result.isRight()) return result;

      final failure = result.fold((l) => l, (_) => throw UnimplementedError());
      final shouldRetry = shouldRetryOnFailure?.call(failure) ?? true;

      debugPrint('[retryEitherUnit] Failure: $failure');
      debugPrint('[retryEitherUnit] Should retry: $shouldRetry');

      attempt++;

      if (attempt >= maxRetries || !shouldRetry) {
        debugPrint('[retryEitherUnit] Giving up after $attempt attempts.');
        return result;
      }

      await Future.delayed(delayBetweenRetries);
    }

    return const Left(UnknownFailure(message: 'RetryUnit failed'));
  }
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});
}
