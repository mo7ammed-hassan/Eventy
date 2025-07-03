import 'package:equatable/equatable.dart';
import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

class ScheduleState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<EventEntity> joinedEvents;
  final List<EventEntity> eventsPerDay;
  final bool isLoadMore;
  final ScheduleViewMode viewMode;
  final DateTime selectedDate;
  final DateTime focusedDate;

  ScheduleState({
    this.isLoading = false,
    this.isLoadMore = false,
    this.errorMessage,
    this.joinedEvents = const [],
    this.eventsPerDay = const [],
    DateTime? selectedDate,
    DateTime? focusedDate,
    this.viewMode = ScheduleViewMode.daily,
  }) : selectedDate = selectedDate ?? DateTime.now(),
       focusedDate = focusedDate ?? DateTime.now();

  ScheduleState copyWith({
    bool? isLoading,
    bool? isLoadMore,
    String? errorMessage,
    List<EventEntity>? joinedEvents,
    List<EventEntity>? eventsPerDay,
    ScheduleViewMode? viewMode,
    DateTime? selectedDate,
    DateTime? focusedDate, 
  }) {
    return ScheduleState(
      isLoading: isLoading ?? this.isLoading,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      errorMessage: errorMessage ?? this.errorMessage,
      joinedEvents: joinedEvents ?? this.joinedEvents,
      eventsPerDay: eventsPerDay ?? this.eventsPerDay,
      viewMode: viewMode ?? this.viewMode,
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDate: focusedDate ?? this.focusedDate,
    );
  }

  List<EventEntity> get currentEvents {
    if (viewMode == ScheduleViewMode.daily) return eventsPerDay;
    return joinedEvents;
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    joinedEvents,
    eventsPerDay,
    isLoadMore,
    viewMode,
    selectedDate,
    focusedDate,
  ];
}
