import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';

class GetPendingEventsUsecase {
  final UserEventsRepository repository;

  GetPendingEventsUsecase(this.repository);
  
  Future<Either<ApiError, List<EventEntity>>> call() =>
      repository.getPendingEvents();
}
