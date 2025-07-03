import 'package:eventy/core/network/api_client.dart';

abstract class ManageUserEventsRemoteDataSource {
  Future<void> joinEvent({required String eventId});

  Future<void> updateEvent({required String eventId});

  Future<void> deleteEvent({required String eventId});

  Future<void> removeFromFavorite({required String eventId});

  Future<void> addToFavorite({required String eventId});
}

class ManageUserEventsRemoteDataSourceImpl
    implements ManageUserEventsRemoteDataSource {
  final ApiClient _apiClient;

  ManageUserEventsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<void> deleteEvent({required String eventId}) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/delete/$eventId',
      method: 'DELETE',
    );

    if (res.statusCode == 200) return;
  }

  @override
  Future<void> joinEvent({required String eventId}) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/attend/$eventId',
      method: 'POST',
    );

    if (res.statusCode == 200) return;
  }

  @override
  Future<void> removeFromFavorite({required String eventId}) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/favorites/$eventId',
      method: 'DELETE',
    );

    if (res.statusCode == 200) return;
  }

  @override
  Future<void> updateEvent({required String eventId}) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/$eventId',
      method: 'PUT',
    );

    if (res.statusCode == 200) return;
  }

  @override
  Future<void> addToFavorite({required String eventId}) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/favorites/$eventId',
      method: 'POST',
    );

    if (res.statusCode == 200) return;
  }
}
