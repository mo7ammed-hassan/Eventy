import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/core/utils/helpers/location_distance_helper.dart';
import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

class GetNearbyEventsUseCase {
  final EventRepository _eventRepository;

  GetNearbyEventsUseCase(this._eventRepository);

  Future<Either<Failure, List<EventEntity>>> call(
    LocationEntity location, {
    double radiusInKm = 300,
    int page = 1,
    int limit = 15,
  }) async {
    final result = await _eventRepository.getAllEvents(
      limit: limit,
      page: page,
    );

    return result.map((allEvents) {
      final userLat = location.latitude;
      final userLng = location.longitude;

      final delta = radiusInKm / 111; 

      final minLat = userLat - delta;
      final maxLat = userLat + delta;
      final minLng = userLng - delta;
      final maxLng = userLng + delta;

      final nearbyRough = allEvents.where((event) {
        final lat = event.location.latitude;
        final lng = event.location.longitude;
        return lat >= minLat && lat <= maxLat && lng >= minLng && lng <= maxLng;
      }).toList();

      final nearbyAccurate = nearbyRough.where((event) {
        final dist = calculateDistanceInKm(
          userLat,
          userLng,
          event.location.latitude,
          event.location.longitude,
        );
        return dist <= radiusInKm;
      }).toList();

      nearbyAccurate.sort((a, b) {
        final d1 = calculateDistanceInKm(
          userLat,
          userLng,
          a.location.latitude,
          a.location.longitude,
        );
        final d2 = calculateDistanceInKm(
          userLat,
          userLng,
          b.location.latitude,
          b.location.longitude,
        );
        return d1.compareTo(d2);
      });

      return nearbyAccurate;
    });
  }
}
