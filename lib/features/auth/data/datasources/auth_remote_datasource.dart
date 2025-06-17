import 'package:dio/dio.dart';
import 'package:eventy/core/api/api_client.dart';
import 'package:eventy/features/auth/data/models/login_model.dart';
import 'package:eventy/features/auth/data/models/reset_passwor_model.dart';
import 'package:eventy/features/auth/data/models/signup_model.dart';

abstract class AuthRemoteDataSource {
  Future<Response> login(LoginModel loginModel);

  Future<void> signup(SignupModel signupModel);

  Future<void> verifyUser({required String email, required int otp});

  Future<void> logout();

  Future<void> resetPassword(ResetPassworModel resetPassworModel);

  Future<void> forgetPassword({required String email});

  Future<void> sendOTP({required String email});

  Future<void> verifyResetPassword({required String email, required int otp});

  Future<void> signInWithGoogle();

  Future<void> signInWithFacebook();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);
  @override
  Future<Response> login(LoginModel loginModel) async {
    return await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/login',
      method: 'POST',
      data: loginModel.toJson(),
    );
  }

  @override
  Future<void> signup(SignupModel signupModel) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/register',
      method: 'POST',
      data: signupModel.toJson(),
    );
  }

  @override
  Future<void> forgetPassword({required String email}) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/forgotpassword',
      method: 'POST',
      data: {'email': email},
    );
  }

  @override
  Future<void> resetPassword(ResetPassworModel resetPassworModel) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/passwordReset',
      method: 'POST',
      data: resetPassworModel.toJson(),
    );
  }

  @override
  Future<void> verifyResetPassword({
    required String email,
    required int otp,
  }) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/confirmPasswordResetCode',
      method: 'POST',
      data: {'email': email, 'confirmCode': otp},
    );
  }

  @override
  Future<void> sendOTP({required String email}) async {
    await forgetPassword(email: email);
  }

  @override
  Future<void> verifyUser({required String email, required int otp}) async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/verifyUser',
      method: 'POST',
      data: {'email': email, 'confirmCode': otp},
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/google',
      method: 'POST',
    );
  }

  @override
  Future<void> signInWithFacebook() {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/logout',
      method: 'GET',
      validateStatus: (status) => status != null && status < 500,
    );
  }
}
