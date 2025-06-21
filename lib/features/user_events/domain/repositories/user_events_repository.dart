import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

abstract class UserEventsRepository {
  Future<Either<ApiError, List<EventEntity>>> getFavoriteEvents({
    int page = 1,
    int limit = 15,
  });
  Future<Either<ApiError, List<EventEntity>>> getCreatedEventEntitys({
    int page = 1,
    int limit = 15,
  });
  Future<Either<ApiError, List<EventEntity>>> getPendingEvents({
    int page = 1,
    int limit = 15,
  });
}
