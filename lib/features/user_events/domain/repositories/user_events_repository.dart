import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

abstract class UserEventsRepository {
  Future<Either<Failure, List<EventEntity>>> getFavoriteEvents({
    int page = 1,
    int limit = 15,
  });
  Future<Either<Failure, List<EventEntity>>> getCreatedEvents({
    int page = 1,
    int limit = 15,
  });
  Future<Either<Failure, List<EventEntity>>> getPendingEvents({
    int page = 1,
    int limit = 15,
  });
  Future<Either<Failure, List<EventEntity>>> getUserJoinedEvents({
    int page = 1,
    int limit = 15,
  });
}
