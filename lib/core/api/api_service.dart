import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/api/api_client.dart';
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
}

// class ApiServices {
//   final ApiClient apiClient;
//   final _storage = getIt.get<SecureStorage>();

//   ApiServices(this.apiClient);

//   // Get Token
//   Future<String?> _getToken() async {
//     return await _storage.getAccessToken();
//   }

//   // Get User Id
//   Future<String?> _getUserId() async {
//     return await _storage.getUserId();
//   }

//   /// Login
//   Future<Either<ApiError, void>> login({required LoginModel loginModel}) async {
//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/login',
//       method: 'POST',
//       data: loginModel.toJson(),
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) async {
//         // save tokens
//         await _storage.saveTokens(
//           accessToken: response.data['data']['accessToken'],
//           refreshToken:
//               response.data['data']['refreshToken'] ??
//               response.data['data']['accessToken'],
//         );

//         // save user id
//         await _storage.saveUserId(response.data['data']['user']['_id']);

//         return const Right(null);
//       },
//     );
//   }

//   /// Register
//   Future<Either<ApiError, void>> signup({
//     required SignupModel signupModel,
//   }) async {
//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/register',
//       method: 'POST',
//       data: signupModel.toJson(),
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) async {
//         return const Right(null);
//       },
//     );
//   }

//   /// Verify User
//   Future<Either<ApiError, void>> verifyUser({
//     required String email,
//     required int otp,
//   }) async {
//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/verifyUser',
//       method: 'POST',
//       data: {'email': email, 'confirmCode': otp},
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) {
//         // await _storage.saveTokens(
//         //   accessToken: response.data['data']['accessToken'],
//         //   refreshToken: response.data['data']['refreshToken'] ??
//         //       response.data['data']['accessToken'],
//         // );
//         // await _storage.saveUserId(response.data['data']['user']['_id']);
//         return const Right(null);
//       },
//     );
//   }

//   /// Forgot Password
//   Future<Either<ApiError, void>> forgetPassword({required String email}) async {
//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/forgotpassword',
//       method: 'POST',
//       data: {'email': email},
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) {
//         return const Right(null);
//       },
//     );
//   }

//   /// Reset Password
//   Future<Either<ApiError, void>> restPassword({
//     required ResetPassworModel resetPassworModel,
//   }) async {
//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/passwordReset',
//       method: 'POST',
//       data: resetPassworModel.toJson(),
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) {
//         return const Right(null);
//       },
//     );
//   }

//   /// Verify Reset Password
//   Future<Either<ApiError, void>> verifyResetPassword({
//     required String email,
//     required int otp,
//   }) async {
//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/confirmPasswordResetCode',
//       method: 'POST',
//       data: {'email': email, 'confirmCode': otp},
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) {
//         return const Right(null);
//       },
//     );
//   }

//   /// Logout
//   Future<Either<ApiError, Unit>> logout() async {
//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/logout',
//       method: 'GET',
//       validateStatus: (status) => status != null && status < 500,
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) async {
//         // delete tokens
//         await _storage.deleteAllTokens();
//         // delete user id
//         await _storage.deleteUserId();

//         return const Right(unit);
//       },
//     );
//   }

//   /// Send OTP
//   Future<Either<ApiError, void>> sendOTP({required String email}) async {
//     return await forgetPassword(email: email);
//   }

//   /// -----------User Profile-----------
//   // Get User
//   Future<Either<ApiError, UserModel>> getUser() async {
//     // get user id
//     final userId = await _getUserId();

//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/viewprofile/$userId',
//       method: 'GET',
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) {
//         return Right(UserModel.fromJson(response.data));
//       },
//     );
//   }

//   // Update User
//   Future<Either<ApiError, UserModel>> updateProfile() async {
//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/updateprofile',
//       method: 'PUT',
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) {
//         return Right(response.data);
//       },
//     );
//   }

//   // Share Profile
//   Future<Either<ApiError, String>> shareProfile() async {
//     // get user id
//     final userId = await _getUserId();

//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/shareprofile/$userId/share',
//       method: 'GET',
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) {
//         return Right(response.data['link']);
//       },
//     );
//   }

//   // Get Customized Events
//   Future<Either<ApiError, List<EventModel>>> getCustomizedEvents() async {
//     // get user id
//     final userId = await _getUserId();

//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/viewprofilewithevent/$userId',
//       // header
//       headers: {'Authorization': 'Bearer ${await _getToken()}'},
//       method: 'GET',
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) {
//         final events = List.from(
//           response.data['registeredEvents'],
//         ).map((e) => EventModel.fromJson(e)).toList();

//         return Right(events);
//       },
//     );
//   }

//   Future<Either<ApiError, void>> signInWithGoogle() async {
//     final response = await apiClient.request(
//       path: 'ce6e.up.railway.app/api/auth/google',
//       method: 'POST',
//     );

//     return response.fold(
//       (error) {
//         return Left(error);
//       },
//       (response) {
//         return const Right(null);
//       },
//     );
//   }

//   /// -----------":"-----------
// }
