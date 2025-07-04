import 'package:eventy/core/utils/helpers/mixins/safe_emit_mixin.dart';
import 'package:eventy/features/create_event/domain/usecases/get_all_events_usecase.dart';
import 'package:eventy/features/search/presentation/cubits/search_state.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> with SafeEmitMixin {
  SearchCubit(this._allEventsUsecase) : super(SearchState());

  final GetAllEventsUsecase _allEventsUsecase;

  final List<EventEntity> _events = [];
  bool _hasFetched = false;

  Future<void> getAllEvents() async {
    if (_hasFetched) return;

    emit(state.copyWith(isLoading: true));

    final result = await _allEventsUsecase.call(limit: 50);

    result.fold(
      (failure) => safeEmit(state.copyWith(isLoading: false, filterList: [])),
      (events) {
        _hasFetched = true;
        _events.addAll(events);

        safeEmit(
          state.copyWith(events: events, filterList: events, isLoading: false),
        );
      },
    );
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      safeEmit(state.copyWith(filterList: []));
      return;
    }
    final filtered = _events
        .where(
          (event) => event.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    safeEmit(state.copyWith(filterList: filtered));
  }
}
