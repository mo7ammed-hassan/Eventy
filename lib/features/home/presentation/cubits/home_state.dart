import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

class HomeState {
  final bool isLoading;
  final bool fetchSuccess;
  final String? errorMessage;
  final bool shouldRequestLocation;
  final List<EventEntity>? nearbyEvents;
  final List<EventEntity>? trendingEvents;
  final List<EventEntity>? upcomingEvents;

  const HomeState({
    this.isLoading = false,
    this.errorMessage = '',
    this.shouldRequestLocation = false,
    this.fetchSuccess = false,
    this.nearbyEvents,
    this.trendingEvents,
    this.upcomingEvents,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? shouldRequestLocation,
    bool? fetchSuccess,
    List<EventEntity>? nearbyEvents,
    List<EventEntity>? trendingEvents,
    List<EventEntity>? upcomingEvents,
  }) => HomeState(
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    shouldRequestLocation: shouldRequestLocation ?? this.shouldRequestLocation,
    fetchSuccess: fetchSuccess ?? this.fetchSuccess,
    nearbyEvents: nearbyEvents ?? this.nearbyEvents,
    trendingEvents: trendingEvents ?? this.trendingEvents,
    upcomingEvents: upcomingEvents ?? this.upcomingEvents,
  );
}
