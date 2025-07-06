import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/core/utils/helpers/mixins/pagination_mixin.dart';
import 'package:eventy/core/utils/helpers/mixins/safe_emit_mixin.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_state.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/get_user_joined_events_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/joined_events_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleCubit extends Cubit<ScheduleState>
    with SafeEmitMixin, PaginationMixin {
  ScheduleCubit({required this.getUserJoinedEventsUsecase})
    : super(ScheduleState());

  final GetUserJoinedEventsUsecase getUserJoinedEventsUsecase;

  final JoinedEventsCubit joinedEventsCubit = getIt<JoinedEventsCubit>();

  final List<EventEntity> joinedEvents = [];
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  Future<void> getJoinedEvents({bool isLoadMore = false}) async {
    safeEmit(state.copyWith(viewMode: ScheduleViewMode.full));
    if (joinedEvents.isNotEmpty && !isLoadMore) return;

    if (!canLoadMore()) return;
    isLoading = true;

    if (joinedEvents.isEmpty) {
      safeEmit(state.copyWith(isLoading: true));
    }

    final result = await getUserJoinedEventsUsecase.call();
    result.fold(
      (failure) {
        hasMore = false;
        safeEmit(
          state.copyWith(errorMessage: failure.message, isLoading: false),
        );
      },
      (events) async {
        if (events.isEmpty) {
          hasMore = false;
        }
        joinedEvents.addAll(events);
        increasePage();

        final newJoinedEvents = List.of(joinedEvents);
        safeEmit(
          state.copyWith(
            joinedEvents: newJoinedEvents,
            isLoadMore: isLoadMore,
            isLoading: false,
            viewMode: ScheduleViewMode.full,
          ),
        );
      },
    );
  }

  Future<void> getEventsPerDay({DateTime? selectedDate}) async {
    safeEmit(state.copyWith(viewMode: ScheduleViewMode.daily));
    
    final newSelectedDate = selectedDate ?? this.selectedDate;
    this.selectedDate = newSelectedDate;

    final filtered = joinedEvents.where((event) {
      return event.date.year == newSelectedDate.year &&
          event.date.month == newSelectedDate.month &&
          event.date.day == newSelectedDate.day;
    }).toList();

    safeEmit(
      state.copyWith(
        eventsPerDay: List.of(filtered),
        viewMode: ScheduleViewMode.daily,
        selectedDate: newSelectedDate,
      ),
    );
  }

  void updateFocusedDate(DateTime focusedDate) {
    final newFocusedDate = DateTime(
      focusedDate.year,
      focusedDate.month,
      focusedDate.day,
    );
    this.focusedDate = focusedDate;
    safeEmit(state.copyWith(focusedDate: newFocusedDate));
  }

  void onSelectDay(DateTime selectedDay, DateTime focusedDay) {
    selectedDate = selectedDay;
    focusedDate = focusedDay;
    getEventsPerDay(selectedDate: selectedDay);
    safeEmit(
      state.copyWith(selectedDate: selectedDay, focusedDate: focusedDay),
    );
  }
}
