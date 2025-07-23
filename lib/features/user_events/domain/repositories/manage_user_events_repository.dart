import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';

abstract class ManageUserEventsRepository {
  Future<Either<Failure, Unit>> joinEvent({required String eventId});

  Future<Either<Failure, Unit>> updateEvent({
    required String eventId,
    required CreateEventEntity event,
  });

  Future<Either<Failure, Unit>> deleteEvent({required String eventId});

  Future<Either<Failure, Unit>> removeFromFavorite({required String eventId});

  Future<Either<Failure, Unit>> addToFavorite({required String eventId});

  Future<Either<Failure, CreateEventEntity>> createEvent({
    required CreateEventEntity event,
  });
}
