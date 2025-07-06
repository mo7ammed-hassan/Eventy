import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/core/utils/helpers/mixins/pagination_mixin.dart';
import 'package:eventy/core/utils/helpers/mixins/safe_emit_mixin.dart';
import 'package:eventy/features/create_event/domain/usecases/get_nearby_events_usecase.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> with SafeEmitMixin, PaginationMixin {
  HomeCubit(this.getNearbyEventsUseCase) : super(HomeState());
  final GetNearbyEventsUseCase getNearbyEventsUseCase;

  final _storage = getIt<AppStorage>();

  final LocationCubit locationCubit = getIt<LocationCubit>();

  bool _hasFetched = false;

  DateTime get todayDateOnly {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  void init() async {
    // _storage.remove('location');
    // _storage.remove('location_permission_denied');

    final location = locationCubit.getLocation();
    final denied = _storage.getBool('location_permission_denied');

    safeEmit(state.copyWith(isLoading: true));

    if (location != null && !denied) {
      safeEmit(state.copyWith(shouldRequestLocation: false, isLoading: false));

      await fetchDependOnLocation(location);
    } else if (denied == true) {
      safeEmit(state.copyWith(shouldRequestLocation: false, isLoading: false));

      await fetchEvents();
    } else if (location == null && denied == false) {
      safeEmit(state.copyWith(shouldRequestLocation: true));
    }
  }

  Future<void> fetchDependOnLocation(LocationEntity location) async {
    if (_hasFetched) return;
    safeEmit(state.copyWith(isLoading: true, shouldRequestLocation: false));

    final result = await getNearbyEventsUseCase(location);
    result.fold(
      (failure) => safeEmit(
        state.copyWith(errorMessage: failure.message, isLoading: false),
      ),
      (events) {
        _hasFetched = true;
        // -- Extract trending events and upcoming events
        final List<EventEntity> trendingEvents = [];
        final List<EventEntity> upcomingEvents = events.where((event) {
          final eventDateOnly = DateTime(
            event.date.year,
            event.date.month,
            event.date.day,
          );
          return eventDateOnly.isAfter(todayDateOnly);
        }).toList();

        safeEmit(
          state.copyWith(
            nearbyEvents: events,
            trendingEvents: trendingEvents,
            upcomingEvents: List.of(upcomingEvents),
            filteredUpcomingEvents: upcomingEvents,
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> fetchEvents() async {
    safeEmit(state.copyWith(isLoading: true, shouldRequestLocation: false));

    // 1. Call your APIs or do the logic
    await Future.delayed(Duration(seconds: 4));

    // 2. Then stop loading

    safeEmit(
      state.copyWith(
        isLoading: false,
        fetchSuccess: true,
        shouldRequestLocation: false,
      ),
    );
  }

  void filterEventsByCategory(String category) {
    final filteredUpcomingEvents = state.upcomingEvents
        ?.where((event) => event.category == category)
        .toList();

    safeEmit(state.copyWith(filteredUpcomingEvents: filteredUpcomingEvents));
  }
}
