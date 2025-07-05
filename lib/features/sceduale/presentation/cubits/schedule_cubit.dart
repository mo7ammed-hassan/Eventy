import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/core/utils/helpers/mixins/pagination_mixin.dart';
import 'package:eventy/core/utils/helpers/mixins/safe_emit_mixin.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_state.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/get_user_joined_events_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleCubit extends Cubit<ScheduleState>
    with SafeEmitMixin, PaginationMixin {
  ScheduleCubit({required this.getUserJoinedEventsUsecase})
    : super(ScheduleState());

  final GetUserJoinedEventsUsecase getUserJoinedEventsUsecase;

  final List<EventEntity> joinedEvents = [];
  DateTime sellectedDate = DateTime.now();
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
    DateTime newSelectedDate = selectedDate ?? state.selectedDate;

    if (selectedDate != null) {
      sellectedDate = selectedDate;
    } else {
      newSelectedDate = DateTime.now();
    }

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
}
