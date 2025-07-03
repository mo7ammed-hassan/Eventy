import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/core/errors/error_handler.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/user_events/data/datasources/user_events_remote_data_source.dart';
import 'package:eventy/features/user_events/data/mapper/event_mapper.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';

class UserEventsRepositoryImpl implements UserEventsRepository {
  final UserEventsRemoteDataSource userEventsRemoteDataSource;

  UserEventsRepositoryImpl(this.userEventsRemoteDataSource, this._storage);
  final SecureStorage _storage;

  Future<String?> _getUserId() async => await _storage.getUserId();
  @override
  Future<Either<Failure, List<EventEntity>>> getCreatedEventEntitys({
    int page = 1,
    int limit = 15,
  }) async {
    try {
      final res = await userEventsRemoteDataSource.getCreatedEvents(
        page: page,
        limit: limit,
      );
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getFavoriteEvents({
    int page = 1,
    int limit = 15,
  }) async {
    try {
      final res = await userEventsRemoteDataSource.getFavoriteEvents(
        page: page,
        limit: limit,
      );
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getPendingEvents({
    int page = 1,
    int limit = 15,
  }) async {
    try {
      final res = await userEventsRemoteDataSource.getPendingEvents(
        page: page,
        limit: limit,
      );
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getUserJoinedEvents({
    int page = 1,
    int limit = 15,
  }) async {
    try {
      final userId = await _getUserId();
      final res = await userEventsRemoteDataSource.getUserJoinedEvents(
        page: page,
        limit: limit,
        userId: userId,
      );
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }
}
