import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';
import 'package:eventy/features/user_events/domain/usecases/generic_user_event_usecase.dart';

class AddEventToFavoriteUsecase
    extends GenericUserEventUsecase<Either<Failure, Unit>, String> {
  final ManageUserEventsRepository repository;

  AddEventToFavoriteUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String eventId) {
    return repository.addToFavorite(eventId: eventId);
  }
}
