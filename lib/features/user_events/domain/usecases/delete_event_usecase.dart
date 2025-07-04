import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';

class DeleteEventUseCase {
  final ManageUserEventsRepository _manageUserEventsRepository;

  DeleteEventUseCase(this._manageUserEventsRepository);

  Future<Either<Failure, Unit>> call({required String eventId}) =>
      _manageUserEventsRepository.deleteEvent(eventId: eventId);
}
