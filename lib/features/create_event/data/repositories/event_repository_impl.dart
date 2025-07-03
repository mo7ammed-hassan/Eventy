import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/error_handler.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/data/datasources/event_remote_data_source.dart';
import 'package:eventy/features/create_event/data/mapper/create_event_mapper.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';
import 'package:eventy/features/user_events/data/mapper/event_mapper.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

class EventRepositoryImpl extends EventRepository {
  final EventRemoteDataSource _remoteDataSource;

  EventRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CreateEventEntity>> createEvent(
    CreateEventEntity event,
  ) async {
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
  Future<Either<Failure, CreateEventEntity>> updateEvent({
    required String eventId,
    required CreateEventEntity event,
  }) async {
    try {
      final result = await _remoteDataSource.updateEvent(
        eventId: eventId,
        data: event.toModel().toJson(),
      );
      return Right(result.toEntity());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }
  
  @override
  Future<Either<Failure, List<EventEntity>>> getAllEvents()async {
    try {
      final result = await _remoteDataSource.getAllEvents();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }
}
