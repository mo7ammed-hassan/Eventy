import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

class LocationState {
  final bool isLoading;
  final LocationEntity? location;
  final String? errorMessage;
  final String? message;

  const LocationState({
    this.isLoading = false,
    this.location,
    this.errorMessage,
    this.message,
  });

  LocationState copyWith({
    bool? isLoading,
    LocationEntity? location,
    String? errorMessage,
    String? message,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      location: location ?? this.location,
      errorMessage: errorMessage,
      message: message,
    );
  }
}
