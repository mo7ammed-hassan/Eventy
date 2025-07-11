import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/location/domain/location_repository.dart';
import 'package:eventy/features/location/presentation/cubits/location_state.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this._loctaionRepository) : super(LocationState()) {
    _init();
  }

  LocationEntity location = LocationEntity.empty();
  final LocationRepository _loctaionRepository;

  void _init() {
    final location = getLocation();
    if (location != null) {
      if (!isClosed) {
        emit(state.copyWith(location: location));
      }
    }
  }

  /// --- Detect user location --- ///
  Future<void> detectUserLocation({bool saveCurrentLocation = true}) async {
    try {
      if (!isClosed) emit(state.copyWith(isLoading: true));

      final hasPermission = await _checkLocationPermission();
      if (!hasPermission) {
        if (!isClosed) emit(state.copyWith(isLoading: false));
        return;
      }

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
      final fullAddress =
          '${address.subAdministrativeArea}, ${address.country}';

      final userAddress = LocationEntity(
        address: fullAddress,
        city: address.subAdministrativeArea ?? '',
        street: address.street ?? '',
        country: address.country ?? '',
        latitude: position.latitude,
        longitude: position.longitude,
      );

      /// --- Save location --- ///
      if (saveCurrentLocation) await saveLocation(userAddress);

      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            location: userAddress,
            errorMessage: null,
            permission: null,
            message: 'Location detected successfully',
          ),
        );
        getIt<UserCubit>().updateLocation(userAddress);
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            message: null,
            permission: null,
            errorMessage: 'Failed to detect location: ${e.toString()}',
          ),
        );
      }
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
          final fullAddress =
              '${address.subAdministrativeArea}, ${address.country}';

          final userAddress = LocationEntity(
            address: fullAddress,
            country: address.country,
            city: address.administrativeArea,
            street: address.street,
            latitude: position.latitude,
            longitude: position.longitude,
          );
          if (!isClosed) emit(state.copyWith(location: userAddress));
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(errorMessage: 'Failed to get last known location'));
      }
    }
  }

  /// --- Listen to location updates --- ///
  Stream<void> listenToLocationUpdates() {
    return Geolocator.getPositionStream(
      locationSettings: _requestLocationSettings(),
    ).asyncMap((position) async {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final address = placemarks.first;
      final fullAddress =
          '${address.subAdministrativeArea}, ${address.country}';
      final userAddress = LocationEntity(
        address: fullAddress,
        city: address.subAdministrativeArea ?? '',
        street: address.street ?? '',
        country: address.country ?? '',
        latitude: position.latitude,
        longitude: position.longitude,
      );

      /// --- Save location --- ///
      await saveLocation(userAddress);

      if (!isClosed) {
        emit(
          state.copyWith(
            location: userAddress,
            errorMessage: null,
            message: 'Location updated successfully',
          ),
        );
      }

      // return LocationEntity(
      //   address: address.country ?? '',
      //   latitude: position.latitude,
      //   longitude: position.longitude,
      // );
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
        if (!isClosed) {
          emit(
            state.copyWith(
              isLoading: false,
              message: null,
              permission: null,
              errorMessage: 'Location service is disabled. Please enable it.',
            ),
          );
        }
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          if (!isClosed) {
            emit(
              state.copyWith(
                isLoading: false,
                message: null,
                errorMessage: 'Location permissions are denied.',
                permission: permission,
              ),
            );
          }
          return false;
        }

        if (permission == LocationPermission.deniedForever) {
          if (!isClosed) {
            emit(
              state.copyWith(
                isLoading: false,
                message: null,
                permission: permission,
                errorMessage:
                    'Location permissions are permanently denied, we cannot request permissions.',
              ),
            );
          }
          return false;
        }
      }

      return true;
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            message: null,
            permission: null,
            errorMessage: 'Permission check failed: ${e.toString()}',
          ),
        );
      }
      return false;
    }
  }

  /// --- Get Permission Location --- ///
  Future<LocationPermission> getPermissionLocation() async {
    return await Geolocator.checkPermission();
  }

  /// --- Recheck permission and detect location --- ///
  Future<bool> recheckPermissionAndDetect() async {
    LocationPermission permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    } else {
      final newPermission = permission;
      if (!isClosed) emit(state.copyWith(permission: newPermission));
      return true;
    }
  }

  /// --- Open Settings --- ///
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  /// --- Save Location --- ///
  Future<void> saveLocation(LocationEntity location) async {
    await _loctaionRepository.saveLocation(location);
  }

  /// --- Get Location --- ///
  LocationEntity? getLocation() {
    LocationEntity? location = _loctaionRepository.getLocation();
    return location;
  }
}
