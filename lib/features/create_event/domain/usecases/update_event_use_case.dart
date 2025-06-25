import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';

class UpdateEventUseCase {
  final EventRepository _eventRepository;

  UpdateEventUseCase(this._eventRepository);

  //Future<Either<ApiError, void>> call() => _eventRepository.updateEvent();
}
