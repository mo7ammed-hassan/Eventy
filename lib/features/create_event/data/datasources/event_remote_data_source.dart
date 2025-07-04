import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<List<EventModel>> getAllEvents({int limit = 15, int page = 1});
}

class EventRemoteDataSourceImpl extends EventRemoteDataSource {
  final ApiClient _apiClient;

  EventRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<EventModel>> getAllEvents({int limit = 15, int page = 1}) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/getevents',
      method: 'GET',
      queryParameters: {'limit': limit, 'page': page},
    );

    final resData = res.data['results'] as List;

    return resData.map((e) => EventModel.fromJson(e)).toList();
  }
}
