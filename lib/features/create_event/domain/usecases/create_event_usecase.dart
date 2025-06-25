import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';

class CreateEventUsecase {
  final EventRepository _eventRepository;

  CreateEventUsecase(this._eventRepository);

  //Future<Either<ApiError, void>> call() => _eventRepository.createEvent();
}