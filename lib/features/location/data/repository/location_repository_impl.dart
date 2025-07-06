import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/location/data/location_model.dart';
import 'package:eventy/features/location/domain/location_repository.dart';
import 'package:eventy/features/user_events/data/mapper/location_mapper.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepositoryImpl extends LocationRepository {
  final SecureStorage _storage;
  final AppStorage _appStorage;
  LocationRepositoryImpl(this._storage, this._appStorage);

  Future<String?> get userId => _storage.getUserId();

  @override
  Future<void> saveLocation(LocationEntity location) async {
    await _appStorage.setJson('location', location.toModel().toJson());
  }

  @override
  Future<bool> checkLocationPermission() {
    throw UnimplementedError();
  }

  @override
  Future<void> detectUserLocation({bool saveCurrentLocation = true}) {
    throw UnimplementedError();
  }

  @override
  Future<void> getLastKnownLocation() {
    throw UnimplementedError();
  }

  @override
  LocationEntity? getLocation() {
    final json = _appStorage.getJson('location');
    if (json == null) return null;
    LocationEntity location = (LocationModel.fromJson(json)).toEntity();
    return location;
  }

  @override
  Stream<void> listenToLocationUpdates() {
    throw UnimplementedError();
  }

  @override
  Future<void> openAppSettings() {
    throw UnimplementedError();
  }

  @override
  LocationSettings requestLocationSettings() {
    throw UnimplementedError();
  }
}
