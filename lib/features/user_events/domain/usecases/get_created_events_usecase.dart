import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';

class GetCreatedEventsUsecase {
  final UserEventsRepository repository;

  GetCreatedEventsUsecase(this.repository);

  Future<Either<ApiError, List<EventEntity>>> call() =>
      repository.getCreatedEventEntitys();
}
