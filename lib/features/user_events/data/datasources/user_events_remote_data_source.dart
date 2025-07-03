import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';

abstract class UserEventsRemoteDataSource {
  Future<List<EventModel>> getFavoriteEvents({int page = 1, int limit = 15});
  Future<List<EventModel>> getCreatedEvents({int page = 1, int limit = 15});
  Future<List<EventModel>> getPendingEvents({int page = 1, int limit = 15});
  Future<List<EventModel>> getUserJoinedEvents({
    int page = 1,
    int limit = 15,
    required String? userId,
  });
}

class UserEventsRemoteDataSourceImpl implements UserEventsRemoteDataSource {
  final ApiClient _apiClient;

  UserEventsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<EventModel>> getCreatedEvents({
    int page = 1,
    int limit = 15,
  }) async {
    final res = await _apiClient.request(
      method: 'GET',
      path: 'ce6e.up.railway.app/api/events/customized',
      queryParameters: {'limit': limit, 'page': page},
    );

    final events = res.data['data'];
    return _parseEvents(events);
  }

  @override
  Future<List<EventModel>> getFavoriteEvents({
    int page = 1,
    int limit = 15,
  }) async {
    final res = await _apiClient.request(
      method: 'GET',
      path: 'ce6e.up.railway.app/api/events/favorites',
      queryParameters: {'limit': limit, 'page': page},
    );

    final events = res.data['data'];
    return _parseEvents(events);
  }

  @override
  Future<List<EventModel>> getPendingEvents({
    int page = 1,
    int limit = 15,
  }) async {
    final res = await _apiClient.request(
      method: 'GET',
      path: 'ce6e.up.railway.app/api/events/pending',
      queryParameters: {'limit': limit, 'page': page},
    );

    final events = res.data['results'];
    return _parseEvents(events);
  }

  @override
  Future<List<EventModel>> getUserJoinedEvents({
    int page = 1,
    int limit = 15,
    required String? userId,
  }) async {
    final res = await _apiClient.request(
      method: 'GET',
      path: 'ce6e.up.railway.app/api/auth/viewprofilewithevent/$userId',
      queryParameters: {'limit': limit, 'page': page},
    );

    final events = res.data['registeredEvents'];
    return _parseEvents(events);
  }

  /// Method Extraction
  List<EventModel> _parseEvents(dynamic raw) {
    if (raw == null || raw is! List || raw.isEmpty) return [];
    return raw.map((e) => EventModel.fromJson(e)).toList();
  }
}
