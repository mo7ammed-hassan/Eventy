import 'dart:math';

///  Haversine Formula
double calculateDistanceInKm(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  /// Earth radius in km
  const double earthRadius = 6371.0;

  /// Difference between latitudes and longitudes
  double dLat = _toRadians(lat2 - lat1);
  double dLon = _toRadians(lon2 - lon1);

  double dlat1 = _toRadians(lat1);
  double dlat2 = _toRadians(lat2);

  /// Haversine Formula
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(dlat1) * cos(dlat2) * sin(dLon / 2) * sin(dLon / 2);

  /// Central Angle
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  //final c = 2 * asin(sqrt(a));

  /// Distance in km
  return earthRadius * c;
}

double _toRadians(double deg) => deg * pi / 180;
