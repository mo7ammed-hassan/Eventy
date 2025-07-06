import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/network/api_client.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/auth/data/models/login_model.dart';
import 'package:eventy/features/auth/data/models/reset_passwor_model.dart';
import 'package:eventy/features/auth/data/models/signup_model.dart';
import 'package:eventy/features/personalization/data/models/user_model.dart';

class ApiServices {
  final ApiClient apiClient;
  final _storage = getIt.get<SecureStorage>();

  ApiServices(this.apiClient);

  Future<String?> _getToken() async => await _storage.getAccessToken();
  Future<String?> _getUserId() async => await _storage.getUserId();

  Future<void> login(LoginModel model) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/login',
      method: 'POST',
      data: model.toJson(),
    );
  }

  Future<void> signup(SignupModel model) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/register',
      method: 'POST',
      data: model.toJson(),
    );
  }

  Future<void> verifyUser(String email, int otp) {
    return apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/verifyUser',
      method: 'POST',
      data: {'email': email, 'confirmCode': otp},
    );
  }

  Future<void> forgetPassword(String email) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/forgotpassword',
      method: 'POST',
      data: {'email': email},
    );
  }

  Future<void> resetPassword(ResetPassworModel model) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/passwordReset',
      method: 'POST',
      data: model.toJson(),
    );
  }

  Future<void> verifyResetPassword(String email, int otp) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/confirmPasswordResetCode',
      method: 'POST',
      data: {'email': email, 'confirmCode': otp},
    );
  }

  Future<void> logout() async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/logout',
      method: 'GET',
      validateStatus: (status) => status != null && status < 500,
    );
  }

  Future<void> sendOTP(String email) async => await forgetPassword(email);

  Future<UserModel> getUser() async {
    final userId = await _getUserId();
    final res = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/viewprofile/$userId',
      method: 'GET',
    );

    return UserModel.fromJson(res.data);
  }

  Future<UserModel> updateProfile({required Map<String, dynamic> data}) async {
    final res = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/updateprofile',
      method: 'PUT',
      data: data,
    );

    return UserModel.fromJson(res.data);
  }

  Future<String> shareProfile() async {
    final userId = await _getUserId();
    final res = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/shareprofile/$userId/share',
      method: 'GET',
    );

    return res.data['link'];
  }

  Future<List<EventModel>> getCustomizedEvents() async {
    final userId = await _getUserId();
    final token = await _getToken();
    final res = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/viewprofilewithevent/$userId',
      headers: {'Authorization': 'Bearer $token'},
      method: 'GET',
    );

    return (res.data['registeredEvents'] as List)
        .map((e) => EventModel.fromJson(e))
        .toList();
  }

  Future<void> signInWithGoogle() async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/google',
      method: 'POST',
    );
  }

  Future<List<dynamic>> chatWithBot(String message) async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/chat',
      method: 'POST',
      data: {'message': message},
    );

    return response.data['response'];
  }
}

