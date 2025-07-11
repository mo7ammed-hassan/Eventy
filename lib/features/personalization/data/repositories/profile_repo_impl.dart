import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/error_handler.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';
import 'package:eventy/core/storage/secure_storage.dart';
import 'package:eventy/features/personalization/data/datasources/profile_remote_data_souces.dart';
import 'package:eventy/features/personalization/data/mappers/user_mappers.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';
import 'package:eventy/features/personalization/domain/repositories/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl(this.profileRemoteDataSource, this._storage);

  final SecureStorage _storage;

  Future<String?> _getToken() async => await _storage.getAccessToken();
  Future<String?> _getUserId() async => await _storage.getUserId();

  @override
  Future<Either<Failure, List<EventModel>>> getCreatedEvents() async {
    try {
      final userId = await _getUserId();
      final token = await _getToken();

      final events = await profileRemoteDataSource.getCreatedEvents(
        userId: userId,
        token: token,
      );
      return Right(events);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserProfile() async {
    try {
      final userId = await _getUserId();
      final user = await profileRemoteDataSource.getUserProfile(userId: userId);
      return Right(user.toEntity());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, String>> shareProfileLink() async {
    try {
      final userId = await _getUserId();
      final link = await profileRemoteDataSource.shareProfileLink(
        userId: userId,
      );
      return Right(link);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserProfile({
    required Map<String, dynamic> data,
  }) async {
    try {
      final user = await profileRemoteDataSource.updateUserProfile(data: data);
      return Right(user.toEntity());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserProfileById({
    required String? id,
  }) async {
    try {
      final user = await profileRemoteDataSource.getUserProfile(userId: id);
      return Right(user.toEntity());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }
}
