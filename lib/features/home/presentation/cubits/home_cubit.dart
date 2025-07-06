import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/core/utils/helpers/mixins/pagination_mixin.dart';
import 'package:eventy/core/utils/helpers/mixins/safe_emit_mixin.dart';
import 'package:eventy/features/create_event/domain/usecases/get_all_events_usecase.dart';
import 'package:eventy/features/create_event/domain/usecases/get_nearby_events_usecase.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> with SafeEmitMixin, PaginationMixin {
  HomeCubit(this.getNearbyEventsUseCase, this.getAllEventsUsecase)
    : super(HomeState());
  final GetNearbyEventsUseCase getNearbyEventsUseCase;
  final GetAllEventsUsecase getAllEventsUsecase;

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

    // if (_hasFetched) return;

    final location = locationCubit.getLocation();
    final denied = _storage.getBool('location_permission_denied');

    safeEmit(state.copyWith(isLoading: true));

    if (location != null && !denied) {
      safeEmit(state.copyWith(shouldRequestLocation: false, isLoading: false));

      await fetchDependOnLocation(location);
    } else if (denied == true && location == null) {
      safeEmit(state.copyWith(shouldRequestLocation: false, isLoading: false));

      await fetchEvents();
    } else if (location == null && denied == false) {
      safeEmit(state.copyWith(shouldRequestLocation: true));
    } else if (location != null && denied == true) {
      safeEmit(state.copyWith(shouldRequestLocation: false, isLoading: false));

      await fetchDependOnLocation(location);
    }
  }

  Future<void> fetchDependOnLocation(
    LocationEntity location, {
    bool forceFetch = false,
    bool hasMore = false,
  }) async {
    if (_hasFetched && !forceFetch && !hasMore) return;

    if (!canLoadMore()) return;
    isLoading = true;

    if (hasMore && !_hasFetched) {
      safeEmit(state.copyWith(isLoading: true, shouldRequestLocation: false));
    }

    final result = await getNearbyEventsUseCase(
      location,
      limit: limit,
      page: page,
    );
    result.fold(
      (failure) => safeEmit(
        state.copyWith(errorMessage: failure.message, isLoading: false),
      ),
      (events) {
        if (events.isEmpty || events.length < limit) {
          hasMore = false;
          hasMore = false;
        }
        _hasFetched = true;
        final List<EventEntity> trendingEvents = events
            .where((element) => element.attendees.length > 2)
            .toList();

        final List<EventEntity> upcomingEvents = events.where((event) {
          final eventDateOnly = DateTime(
            event.date.year,
            event.date.month,
            event.date.day,
          );
          return eventDateOnly.isBefore(todayDateOnly);
        }).toList();

        if (hasMore) {
          trendingEvents.addAll(state.trendingEvents!);
        }

        if (hasMore) {
          upcomingEvents.addAll(state.upcomingEvents!);
        }

        increasePage();

        safeEmit(
          state.copyWith(
            trendingEvents: List.of(trendingEvents),
            upcomingEvents: List.of(upcomingEvents),
            filteredUpcomingEvents: List.of(upcomingEvents),
            filterdTrendingEvents: List.of(trendingEvents),
            filteredEvents: List.of(events),
            isLoading: false,
          ),
        );
      },
    );
    isLoading = false;
  }

  Future<void> fetchEvents({
    bool forceFetch = false,
    bool hasMore = false,
  }) async {
    if (_hasFetched && !forceFetch && !hasMore) return;

    if (!canLoadMore()) return;
    isLoading = true;

    if (hasMore && !_hasFetched) {
      safeEmit(state.copyWith(isLoading: true, shouldRequestLocation: false));
    }

    final result = await getAllEventsUsecase.call();
    result.fold(
      (failure) => safeEmit(state.copyWith(errorMessage: failure.message)),
      (events) {
        if (events.isEmpty || events.length < limit) {
          hasMore = false;
          hasMore = false;
        }
        _hasFetched = true;
        // -- Extract trending events and upcoming events
        final List<EventEntity> trendingEvents = events
            .where((element) => element.attendees.length > 2)
            .toList();
        final List<EventEntity> upcomingEvents = events.where((event) {
          final eventDateOnly = DateTime(
            event.date.year,
            event.date.month,
            event.date.day,
          );
          return eventDateOnly.isAfter(todayDateOnly);
        }).toList();

        if (hasMore) {
          upcomingEvents.addAll(state.upcomingEvents!);
        }

        if (hasMore) {
          trendingEvents.addAll(state.trendingEvents!);
        }

        increasePage();

        safeEmit(
          state.copyWith(
            trendingEvents: List.of(trendingEvents),
            upcomingEvents: List.of(upcomingEvents),
            filteredUpcomingEvents: List.of(upcomingEvents),
            isLoading: false,
          ),
        );
      },
    );
    isLoading = false;
  }

  void filterEventsByCategory(String category) {
    if (category == 'All' || category == 'Best') {
      safeEmit(
        state.copyWith(
          filteredUpcomingEvents: state.upcomingEvents,
          filterdTrendingEvents: state.trendingEvents,
        ),
      );
      return;
    }
    final filteredUpcomingEvents = state.upcomingEvents
        ?.where((event) => event.category == category)
        .toList();

    final filteredTrendingEvents = state.trendingEvents
        ?.where((event) => event.category == category)
        .toList();

    safeEmit(
      state.copyWith(
        filteredUpcomingEvents: filteredUpcomingEvents,
        filterdTrendingEvents: filteredTrendingEvents,
      ),
    );
  }
}
