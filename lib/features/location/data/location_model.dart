class LocationModel {
  String? address;
  double? latitude;
  double? longitude;
  String? country;
  String? city;
  String? street;

  LocationModel({
    this.address,
    this.latitude,
    this.longitude,
    this.country,
    this.city,
    this.street,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    address: json['address'] as String?,
    country: json['country'] as String?,
    city: json['city'] as String?,
    street: json['street'] as String?,
    latitude: json['latitude'] is num
        ? (json['latitude'] as num).toDouble()
        : null,
    longitude: json['longitude'] is num
        ? (json['longitude'] as num).toDouble()
        : null,
  );

  Map<String, dynamic> toJson() => {
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'country': country,
    'city': city,
    'street': street,
  };
}
