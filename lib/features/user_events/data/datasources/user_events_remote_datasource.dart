import 'package:eventy/core/api/api_client.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';

abstract class UserEventsRemoteDataSource {
  Future<List<EventModel>> getFavoriteEvents();
  Future<List<EventModel>> getCreatedEvents();
  Future<List<EventModel>> getPendingEvents();
}

class UserEventsRemoteDataSourceImpl implements UserEventsRemoteDataSource {
  final ApiClient _apiClient;

  UserEventsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<EventModel>> getCreatedEvents() async {
    final res = await _apiClient.request(
      method: 'GET',
      path: 'ce6e.up.railway.app/api/events/customized',
      // headers: {'Authorization': 'Bearer $token'},
      queryParameters: {'limit': 20, 'skip': 0},
    );

    final events = res.data['data'] as List<dynamic>;

    return events.map((e) => EventModel.fromJson(e)).toList();
  }

  @override
  Future<List<EventModel>> getFavoriteEvents() async {
    final res = await _apiClient.request(
      method: 'GET',
      path: 'ce6e.up.railway.app/api/events/favorites',
    );

    final events = res.data['data'] as List<dynamic>;

    return events.map((e) => EventModel.fromJson(e)).toList();
  }

  @override
  Future<List<EventModel>> getPendingEvents() async {
    final res = await _apiClient.request(
      method: 'GET',
      path: 'ce6e.up.railway.app/api/events/pending',
       queryParameters: {'limit': 20, 'page': 1},
    );

    final events = res.data['pendingEvents'] as List<dynamic>;

    return events.map((e) => EventModel.fromJson(e)).toList();
  }
}
