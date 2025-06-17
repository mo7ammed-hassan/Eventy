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
  Future<Either<ApiError, List<EventEntity>>> getCreatedEventEntitys() async {
    try {
      final res = await userEventsRemoteDataSource.getCreatedEvents();
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, List<EventEntity>>> getFavoriteEvents() async {
    try {
      final res = await userEventsRemoteDataSource.getFavoriteEvents();
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, List<EventEntity>>> getPendingEvents() async {
    try {
      final res = await userEventsRemoteDataSource.getPendingEvents();
      return Right(res.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
