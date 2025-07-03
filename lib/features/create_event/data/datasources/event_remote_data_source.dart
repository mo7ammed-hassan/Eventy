import 'package:dio/dio.dart';
import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/core/network/api_response.dart';
import 'package:eventy/features/create_event/data/models/create_event_model.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<CreateEventModel> createEvent(Map<String, dynamic> data);
  Future<CreateEventModel> updateEvent({
    required String eventId,
    required Map<String, dynamic> data,
  });
  Future<CreateEventModel> deleteEvent({required String eventId});

    Future<List<EventModel>> getAllEvents();
}

class EventRemoteDataSourceImpl extends EventRemoteDataSource {
  final ApiClient _apiClient;

  EventRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CreateEventModel> createEvent(Map<String, dynamic> data) async {
    final imagePath = data['image'] as String?;
    final imageFile = imagePath != null
        ? await MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split('/').last,
          )
        : null;

    final coverImagePath = data['coverImage'] as String?;
    final coverImageFile = coverImagePath != null
        ? await MultipartFile.fromFile(
            coverImagePath,
            filename: coverImagePath.split('/').last,
          )
        : null;

    final formMap = Map<String, dynamic>.from(data)
      ..remove('image')
      ..remove('coverImage');

    if (imageFile != null) {
      formMap['image'] = imageFile;
    }
    if (coverImageFile != null) {
      formMap['coverImage'] = coverImageFile;
    }

    final formData = FormData.fromMap(formMap);

    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/events/addevents',
      method: 'POST',
      data: formData,
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
      method: 'DELETE',
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
      method: 'PUT',
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
