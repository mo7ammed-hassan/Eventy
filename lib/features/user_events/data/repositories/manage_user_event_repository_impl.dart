import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/error_handler.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/data/mapper/create_event_mapper.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/user_events/data/datasources/manage_user_events_remote_datasource.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';

class ManageUserEventRepositoryImpl implements ManageUserEventsRepository {
  final ManageUserEventsRemoteDataSource _remoteDataSource;

  ManageUserEventRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CreateEventEntity>> createEvent({
    required CreateEventEntity event,
  }) async {
    try {
      final result = await _remoteDataSource.createEvent(
        event.toModel().toJson(),
      );
      return Right(result.toEntity());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateEvent({
    required String eventId,
    required CreateEventEntity event,
  }) async {
    try {
      await _remoteDataSource.updateEvent(
        eventId: eventId,
        data: event.toModel().toJson(),
      );
      return Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEvent({required String eventId}) async {
    try {
      await _remoteDataSource.deleteEvent(eventId: eventId);
      return const Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> addToFavorite({required String eventId}) async {
    try {
      await _remoteDataSource.addToFavorite(eventId: eventId);
      return const Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromFavorite({
    required String eventId,
  }) async {
    try {
      await _remoteDataSource.removeFromFavorite(eventId: eventId);
      return const Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> joinEvent({required String eventId}) async {
    try {
      await _remoteDataSource.joinEvent(eventId: eventId);
      return const Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }
}
