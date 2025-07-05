import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';

class JoinEventUsecase {
  final ManageUserEventsRepository manageUserEventsRepository;

  JoinEventUsecase(this.manageUserEventsRepository);

  Future<Either<Failure, Unit>> call({required String eventId}) =>
      manageUserEventsRepository.joinEvent(eventId: eventId);
}
