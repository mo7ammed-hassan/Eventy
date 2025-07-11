import 'package:equatable/equatable.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:geolocator/geolocator.dart';

class LocationState extends Equatable {
  final bool isLoading;
  final LocationEntity? location;
  final String? errorMessage;
  final String? message;
  final LocationPermission? permission;

  const LocationState({
    this.isLoading = false,
    this.location,
    this.errorMessage,
    this.message,
    this.permission,
  });

  LocationState copyWith({
    bool? isLoading,
    LocationEntity? location,
    String? errorMessage,
    String? message,
    LocationPermission? permission,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      location: location ?? this.location,
      errorMessage: errorMessage,
      message: message,
      permission: permission ?? this.permission,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, message, permission];
}
