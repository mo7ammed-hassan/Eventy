import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<List<EventModel>> getAllEvents();
}

class EventRemoteDataSourceImpl extends EventRemoteDataSource {
  final ApiClient _apiClient;

  EventRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<EventModel>> getAllEvents() async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/getevents',
      method: 'GET',
      queryParameters: {'limit': 50, 'page': 1},
    );

    final resData = res.data['results'] as List;

    return resData.map((e) => EventModel.fromJson(e)).toList();
  }
}
