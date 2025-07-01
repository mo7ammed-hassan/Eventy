import 'package:eventy/features/location/data/location_model.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

extension LocationMapper on LocationModel {
  LocationEntity toEntity() => LocationEntity(
    address: address ?? 'unknown',
    country: country ?? 'unknown',
    city: city ?? 'unknown',
    street: street ?? 'unknown',
    latitude: latitude ?? 0.0,
    longitude: longitude ?? 0.0,
  );
}

extension LocationEntityMapper on LocationEntity {
  LocationModel toModel() => LocationModel(
    address: address,
    country: country,
    city: city,
    street: street,
    latitude: latitude,
    longitude: longitude,
  );
}
