import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

class GetAllEventsUsecase {
  final EventRepository _eventRepository;

  GetAllEventsUsecase(this._eventRepository);

  Future<Either<Failure, List<EventEntity>>> call({
    int page = 1,
    int limit = 15,
  }) async {
    return await _eventRepository.getAllEvents(limit: limit, page: page);
  }
}
