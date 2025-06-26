import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/core/network/api_response.dart';
import 'package:eventy/features/create_event/data/models/create_event_model.dart';

abstract class EventRemoteDataSource {
  Future<CreateEventModel> createEvent(Map<String, dynamic> data);
  Future<CreateEventModel> updateEvent({
    required String eventId,
    required Map<String, dynamic> data,
  });
  Future<CreateEventModel> deleteEvent({required String eventId});
}

class EventRemoteDataSourceImpl extends EventRemoteDataSource {
  final ApiClient _apiClient;

  EventRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CreateEventModel> createEvent(Map<String, dynamic> data) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/addevents',
      data: data,
    );

    final resData = ApiResponse<CreateEventModel>.fromJson(
      res.data,
      'event',
      CreateEventModel.fromJson,
    );

    return resData.data!;
  }

  @override
  Future<CreateEventModel> deleteEvent({required String eventId}) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/delete/$eventId',
    );

    final resData = ApiResponse<CreateEventModel>.fromJson(
      res.data,
      'event',
      CreateEventModel.fromJson,
    );

    return resData.data!;
  }

  @override
  Future<CreateEventModel> updateEvent({
    required String eventId,
    required Map<String, dynamic> data,
  }) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/update/$eventId',
      data: data,
    );

    final resData = ApiResponse<CreateEventModel>.fromJson(
      res.data,
      'event',
      CreateEventModel.fromJson,
    );

    return resData.data!;
  }
}
