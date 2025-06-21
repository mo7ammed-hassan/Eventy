import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/data/datasources/user_events_remote_datasource.dart';
import 'package:eventy/features/user_events/data/mapper/event_mapper.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';

class UserEventsRepositoryImpl implements UserEventsRepository {
  final UserEventsRemoteDataSource userEventsRemoteDataSource;

  UserEventsRepositoryImpl(this.userEventsRemoteDataSource);
  @override
  Future<Either<ApiError, List<EventEntity>>> getCreatedEventEntitys({
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
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, List<EventEntity>>> getFavoriteEvents({
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
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, List<EventEntity>>> getPendingEvents({
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
      return Left(ErrorHandler.handle(e));
    }
  }
}
