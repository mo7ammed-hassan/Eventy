import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

abstract class UserEventsRepository {
  Future<Either<ApiError, List<EventEntity>>> getFavoriteEvents();
  Future<Either<ApiError, List<EventEntity>>> getCreatedEventEntitys();
  Future<Either<ApiError, List<EventEntity>>> getPendingEvents();
}
