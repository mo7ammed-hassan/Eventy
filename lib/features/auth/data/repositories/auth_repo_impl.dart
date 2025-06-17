import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:eventy/features/auth/data/models/login_model.dart';
import 'package:eventy/features/auth/data/models/reset_passwor_model.dart';
import 'package:eventy/features/auth/data/models/signup_model.dart';
import 'package:eventy/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final SecureStorage _storage;

  AuthRepoImpl(this.authRemoteDataSource, this._storage);

  @override
  Future<Either<ApiError, Unit>> login({required LoginModel loginModel}) async {
    try {
      final response = await authRemoteDataSource.login(loginModel);

      await _storage.saveTokens(
        accessToken: response.data['data']['accessToken'],
        refreshToken:
            response.data['data']['refreshToken'] ??
            response.data['data']['accessToken'],
      );

      await _storage.saveUserId(response.data['data']['user']['_id']);

      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, Unit>> logout() async {
    try {
      await authRemoteDataSource.logout();

      await _storage.deleteAllTokens();
      await _storage.deleteUserId();
      
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, Unit>> signup({
    required SignupModel signupModel,
  }) async {
    try {
      await authRemoteDataSource.signup(signupModel);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, Unit>> forgetPassword({required String email}) async {
    try {
      await authRemoteDataSource.forgetPassword(email: email);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, Unit>> resetPassword({
    required ResetPassworModel resetPassworModel,
  }) async {
    try {
      await authRemoteDataSource.resetPassword(resetPassworModel);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, Unit>> sendOTP({required String email}) async {
    try {
      await authRemoteDataSource.sendOTP(email: email);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, Unit>> verifyResetPassword({
    required String email,
    required int otp,
  }) async {
    try {
      await authRemoteDataSource.verifyResetPassword(email: email, otp: otp);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, Unit>> verifyUser({
    required String email,
    required int otp,
  }) async {
    try {
      await authRemoteDataSource.verifyUser(email: email, otp: otp);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, Unit>> signInWithFacebook() async {
    try {
      await authRemoteDataSource.signInWithFacebook();
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ApiError, Unit>> signInWithGoogle() async {
    try {
      await authRemoteDataSource.signInWithGoogle();
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
