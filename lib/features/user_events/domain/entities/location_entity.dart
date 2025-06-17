class LocationEntity {
  final String address;
  final double latitude;
  final double longitude;

  LocationEntity({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  static empty() => LocationEntity(address: '', latitude: 0.0, longitude: 0.0);
}
