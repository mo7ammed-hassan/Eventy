import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:geolocator/geolocator.dart';

/// Manage Location Service
/// Store Location as JSON
/// Get Location
/// Listen to Location Updates
abstract class LocationRepository {
  // Store Location
  Future<void> saveLocation(LocationEntity location);

  /// Get Location
  LocationEntity? getLocation();

  // Listen to Location Updates
  Stream<void> listenToLocationUpdates();

  // Detect User Location
  Future<void> detectUserLocation({bool saveCurrentLocation = true});

  // Get Last Known Location
  Future<void> getLastKnownLocation();

  // Check Location Permission
  Future<bool> checkLocationPermission();

  // Request Location Settings
  LocationSettings requestLocationSettings();

  // Open App Settings
  Future<void> openAppSettings();
}
