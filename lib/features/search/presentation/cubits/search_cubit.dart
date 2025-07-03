import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<List<EventEntity>> {
  SearchCubit(this._eventRepository) : super([]);

  final EventRepository _eventRepository;

  final List<EventEntity> _events = [];

  Future<void> getAllEvents() async {
    final result = await _eventRepository.getAllEvents();

    result.fold((failure) => emit([]), (events) {
      _events.addAll(events);
    });
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      emit([]);
      return;
    }
    final filtered = _events
        .where(
          (event) => event.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    emit(List.of(filtered));
  }
}
