import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String? address;
  final double latitude;
  final double longitude;
  final String? country;
  final String? city;
  final String? street;

  String get fullAddress => '$street, $city, $country';

  LocationEntity copyWith({
    String? address,
    double? latitude,
    double? longitude,
    String? country,
    String? city,
    String? street,
  }) {
    return LocationEntity(
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  const LocationEntity({
    this.address,
    required this.latitude,
    required this.longitude,
    this.country,
    this.city,
    this.street,
  });

  static empty() => LocationEntity(address: '', latitude: 0.0, longitude: 0.0);

  @override
  List<Object?> get props => [
    address,
    latitude,
    longitude,
    country,
    city,
    street,
  ];
}
