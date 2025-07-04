import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';

class CreateEventUsecase {
  final ManageUserEventsRepository _manageUserEventRepository;

  CreateEventUsecase(this._manageUserEventRepository);

  Future<Either<Failure, CreateEventEntity>> call({
    required CreateEventEntity event,
  }) => _manageUserEventRepository.createEvent(event: event);
}
