import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';

class GetFavoriteEventsUsecase {
  final UserEventsRepository repository;

  GetFavoriteEventsUsecase(this.repository);

  Future<Either<Failure, List<EventEntity>>> call({
    int page = 1,
    int limit = 15,
  }) => repository.getFavoriteEvents(page: page, limit: limit);
}
