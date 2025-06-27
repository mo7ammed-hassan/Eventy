class LocationModel {
  String? address;
  double? latitude;
  double? longitude;

  LocationModel({this.address, this.latitude, this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    address: json['address'] as String?,
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
  };
}
