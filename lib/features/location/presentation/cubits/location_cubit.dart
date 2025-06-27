import 'package:eventy/features/location/presentation/cubits/location_state.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationState());

  /// --- Detect user location --- ///
  Future<void> detectUserLocation() async {
    try {
      final hasPermission = await _checkLocationPermission();
      if (!hasPermission) return;

      emit(state.copyWith(isLoading: true));

      final LocationSettings locationSettings = _requestLocationSettings();

      // --- Get user location
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      // -- Convert location to address
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final address = placemarks.first;

      final userAddress = LocationEntity(
        address: address.country ?? '',
        latitude: position.latitude,
        longitude: position.longitude,
      );

      emit(
        state.copyWith(
          isLoading: false,
          location: userAddress,
          errorMessage: null,
          message: 'Location detected successfully',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          message: null,
          errorMessage: 'Failed to detect location: ${e.toString()}',
        ),
      );
    }
  }

  /// --- Get last known location --- ///
  Future<void> getLastKnownLocation() async {
    try {
      final Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          final address = placemarks.first;
          emit(
            state.copyWith(
              location: LocationEntity(
                address: address.country ?? '',
                latitude: position.latitude,
                longitude: position.longitude,
              ),
            ),
          );
        }
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to get last known location'));
    }
  }

  /// --- Listen to location updates --- ///
  Stream<LocationEntity> listenToLocationUpdates() {
    return Geolocator.getPositionStream(
      locationSettings: _requestLocationSettings(),
    ).asyncMap((position) async {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      return LocationEntity(
        address: placemarks.isEmpty ? '' : placemarks.first.country ?? '',
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }

  /// --- Request location settings based on platform --- ///
  LocationSettings _requestLocationSettings() {
    // --- Request location permission for Android & iOS & MacOS
    late LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationTitle: 'Location Access',
          notificationText: 'Allow Eventy to access your location?',
          notificationIcon: AndroidResource(name: '@mipmap/ic_launcher'),
          enableWakeLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: false,
        showBackgroundLocationIndicator: true,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    return locationSettings;
  }

  /// --- Check location permission --- ///
  Future<bool> _checkLocationPermission() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        emit(
          state.copyWith(
            isLoading: false,
            message: null,
            errorMessage: 'Location service is disabled. Please enable it.',
          ),
        );
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          emit(
            state.copyWith(
              isLoading: false,
              message: null,
              errorMessage: 'Location permissions are denied.',
            ),
          );
          return false;
        }

        if (permission == LocationPermission.deniedForever) {
          emit(
            state.copyWith(
              isLoading: false,
              message: null,
              errorMessage:
                  'Location permissions are permanently denied, we cannot request permissions.',
            ),
          );
          return false;
        }
      }

      return true;
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          message: null,
          errorMessage: 'Permission check failed: ${e.toString()}',
        ),
      );
      return false;
    }
  }
}
