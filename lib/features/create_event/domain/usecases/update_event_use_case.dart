import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';

class UpdateEventUseCase {
  final EventRepository _eventRepository;

  UpdateEventUseCase(this._eventRepository);

  Future<Either<Failure, void>> call({
    required CreateEventEntity event,
    required String eventId,
  }) => _eventRepository.updateEvent(eventId: eventId, event: event);
}
