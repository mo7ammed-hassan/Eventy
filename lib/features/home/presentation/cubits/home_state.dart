import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

class HomeState {
  final bool isLoading;
  final bool fetchSuccess;
  final String? errorMessage;
  final bool shouldRequestLocation;
  final List<EventEntity>? trendingEvents;
  final List<EventEntity>? upcomingEvents;
  final List<EventEntity>? filteredEvents;
  final List<EventEntity>? filteredUpcomingEvents;
  final List<EventEntity>? filterdTrendingEvents;

  const HomeState({
    this.isLoading = false,
    this.errorMessage = '',
    this.shouldRequestLocation = false,
    this.fetchSuccess = false,
    this.trendingEvents,
    this.upcomingEvents,
    this.filteredEvents,
    this.filteredUpcomingEvents,
    this.filterdTrendingEvents,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? shouldRequestLocation,
    bool? fetchSuccess,
    List<EventEntity>? trendingEvents,
    List<EventEntity>? upcomingEvents,
    List<EventEntity>? filteredEvents,
    List<EventEntity>? filteredUpcomingEvents,
    List<EventEntity>? filterdTrendingEvents,
  }) => HomeState(
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    shouldRequestLocation: shouldRequestLocation ?? this.shouldRequestLocation,
    fetchSuccess: fetchSuccess ?? this.fetchSuccess,
    trendingEvents: trendingEvents ?? this.trendingEvents,
    upcomingEvents: upcomingEvents ?? this.upcomingEvents,
    filteredEvents: filteredEvents ?? this.filteredEvents,
    filteredUpcomingEvents:
        filteredUpcomingEvents ?? this.filteredUpcomingEvents,
    filterdTrendingEvents:
        filterdTrendingEvents ?? this.filterdTrendingEvents,
  );
}
