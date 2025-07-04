import 'package:eventy/core/utils/helpers/mixins/safe_emit_mixin.dart';
import 'package:eventy/features/create_event/domain/usecases/get_all_events_usecase.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<List<EventEntity>> with SafeEmitMixin {
  SearchCubit(this._allEventsUsecase) : super([]);

  final GetAllEventsUsecase _allEventsUsecase;

  final List<EventEntity> _events = [];
  bool _hasFetched = false;

  Future<void> getAllEvents() async {
    if (_hasFetched) return;

    final result = await _allEventsUsecase.call(limit: 50);

    result.fold((failure) => safeEmit([]), (events) {
      _events.addAll(events);
      _hasFetched = true;
    });
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      safeEmit([]);
      return;
    }
    final filtered = _events
        .where(
          (event) => event.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    safeEmit(List.of(filtered));
  }
}
