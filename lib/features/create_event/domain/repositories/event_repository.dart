import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, CreateEventEntity>> createEvent(
    CreateEventEntity event,
  );

  Future<Either<Failure, CreateEventEntity>> updateEvent({
   required String eventId,
   required CreateEventEntity event,
  });

  Future<Either<Failure, Unit>> deleteEvent({required String eventId});
}
