import 'package:dartz/dartz.dart';
import 'package:eventy/core/abstract_service/event_enricher_service.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/core/errors/error_handler.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/user_events/data/datasources/user_events_remote_data_source.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';

class UserEventsRepositoryImpl implements UserEventsRepository {
  final UserEventsRemoteDataSource userEventsRemoteDataSource;
  final EventEnricherService eventEnricherService;

  UserEventsRepositoryImpl(
    this.userEventsRemoteDataSource,
    this._storage,
    this.eventEnricherService,
  );
  final SecureStorage _storage;

  Future<String?> _getUserId() async => await _storage.getUserId();
  @override
  Future<Either<Failure, List<EventEntity>>> getCreatedEvents({
    int page = 1,
    int limit = 15,
  }) async {
    try {
      final res = await userEventsRemoteDataSource.getCreatedEvents(
        page: page,
        limit: limit,
      );

      final eventWithHost = await eventEnricherService.enrichEventsWithUsers(
        events: res,
      );

      return Right(eventWithHost);
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

      final eventWithHost = await eventEnricherService.enrichEventsWithUsers(
        events: res,
      );

      return Right(eventWithHost);
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

      final eventWithHost = await eventEnricherService.enrichEventsWithUsers(
        events: res,
      );
      return Right(eventWithHost);
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

      final eventWithHost = await eventEnricherService.enrichEventsWithUsers(
        events: res,
      );

      return Right(eventWithHost);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }
}
