class LocationModel {
  String? address;
  double? latitude;
  double? longitude;

  LocationModel({this.address, this.latitude, this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    address: json['address'] as String?,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
  };
}
