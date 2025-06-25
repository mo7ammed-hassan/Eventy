import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';

class DeleteEventUseCase {
  final EventRepository _eventRepository;

  DeleteEventUseCase(this._eventRepository);

  //Future<Either<ApiError, void>> call() => _eventRepository.deleteEvent();
}
