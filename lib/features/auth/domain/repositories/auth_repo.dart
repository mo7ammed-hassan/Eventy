import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/auth/data/models/login_model.dart';
import 'package:eventy/features/auth/data/models/reset_passwor_model.dart';
import 'package:eventy/features/auth/data/models/signup_model.dart';

abstract class AuthRepo {
  Future<Either<ApiError, Unit>> login({required LoginModel loginModel});

  Future<Either<ApiError, Unit>> signup({required SignupModel signupModel});

  Future<Either<ApiError, Unit>> verifyUser({
    required String email,
    required int otp,
  });

  Future<Either<ApiError, Unit>> logout();

  Future<Either<ApiError, Unit>> forgetPassword({required String email});

  Future<Either<ApiError, Unit>> resetPassword({
    required ResetPassworModel resetPassworModel,
  });

  Future<Either<ApiError, Unit>> sendOTP({required String email});

  Future<Either<ApiError, Unit>> verifyResetPassword({
    required String email,
    required int otp,
  });

  Future<Either<ApiError, Unit>> signInWithGoogle();

  Future<Either<ApiError, Unit>> signInWithFacebook();
}
