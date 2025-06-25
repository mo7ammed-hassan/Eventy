import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/auth/data/models/login_model.dart';
import 'package:eventy/features/auth/data/models/reset_passwor_model.dart';
import 'package:eventy/features/auth/data/models/signup_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, Unit>> login({required LoginModel loginModel});

  Future<Either<Failure, Unit>> signup({required SignupModel signupModel});

  Future<Either<Failure, Unit>> verifyUser({
    required String email,
    required int otp,
  });

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> forgetPassword({required String email});

  Future<Either<Failure, Unit>> resetPassword({
    required ResetPassworModel resetPassworModel,
  });

  Future<Either<Failure, Unit>> sendOTP({required String email});

  Future<Either<Failure, Unit>> verifyResetPassword({
    required String email,
    required int otp,
  });

  Future<Either<Failure, Unit>> signInWithGoogle();

  Future<Either<Failure, Unit>> signInWithFacebook();
}
