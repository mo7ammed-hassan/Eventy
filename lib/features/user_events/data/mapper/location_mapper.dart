import 'package:eventy/features/user_events/data/models/location_model.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

extension LocationMapper on LocationModel {
  LocationEntity toEntity() => LocationEntity(
    address: address ?? 'unknown',
    latitude: latitude ?? 0.0,
    longitude: longitude ?? 0.0,
  );
}

extension LocationEntityMapper on LocationEntity {
  LocationModel toModel() =>
      LocationModel(address: address, latitude: latitude, longitude: longitude);
}
