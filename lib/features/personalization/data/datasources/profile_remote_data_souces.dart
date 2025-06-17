import 'package:eventy/core/api/api_client.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';
import 'package:eventy/features/personalization/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getUserProfile({required String? userId});
  Future<UserModel> updateUserProfile();
  Future<String> shareProfileLink({required String? userId});

  Future<List<EventModel>> getCreatedEvents({
    required String? userId,
    required String? token,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserModel> getUserProfile({required String? userId}) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/viewprofile/$userId',
      method: 'GET',
    );

    return UserModel.fromJson(res.data);
  }

  @override
  Future<String> shareProfileLink({required String? userId}) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/shareprofile/$userId/share',
      method: 'GET',
    );

    return res.data['link'];
  }

  @override
  Future<UserModel> updateUserProfile() async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/updateprofile',
      method: 'PUT',
    );

    return UserModel.fromJson(res.data);
  }

  @override
  Future<List<EventModel>> getCreatedEvents({
    required String? userId,
    required String? token,
  }) async {
    final res = await _apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/viewprofilewithevent/$userId',
      headers: {'Authorization': 'Bearer $token'},
      method: 'GET',
    );

    final events = res.data['registeredEvents'] as List;

    return events.map((e) => EventModel.fromJson(e)).toList();
  }
}
