import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

class SearchState {
  final bool isLoading;
  final List<EventEntity> events;
  final List<EventEntity> filterList;

  SearchState({this.isLoading = false, this.events = const [], this.filterList = const [] });

  // copyWith
  SearchState copyWith({
    bool? isLoading,
    List<EventEntity>? events,
    List<EventEntity>? filterList,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      filterList: filterList ?? this.filterList,
    );
  }
}
