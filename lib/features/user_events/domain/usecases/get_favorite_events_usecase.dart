import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';

class GetFavoriteEventsUsecase {
  final UserEventsRepository repository;

  GetFavoriteEventsUsecase(this.repository);

  Future<Either<ApiError, List<EventEntity>>> call() =>
      repository.getFavoriteEvents();
}
