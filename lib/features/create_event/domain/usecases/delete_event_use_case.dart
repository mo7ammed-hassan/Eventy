import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';

class DeleteEventUseCase {
  final EventRepository _eventRepository;

  DeleteEventUseCase(this._eventRepository);

  Future<Either<Failure, void>> call({required String eventId}) =>
      _eventRepository.deleteEvent(eventId: eventId);
}
