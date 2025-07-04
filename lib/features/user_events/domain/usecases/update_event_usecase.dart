import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';

class UpdateEventUseCase {
  final ManageUserEventsRepository _manageUserEventsRepository;

  UpdateEventUseCase(this._manageUserEventsRepository);

  Future<Either<Failure, void>> call({
    required CreateEventEntity event,
    required String eventId,
  }) => _manageUserEventsRepository.updateEvent(eventId: eventId , event: event);
}
