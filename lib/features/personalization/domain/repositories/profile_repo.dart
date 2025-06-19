import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';

abstract class ProfileRepo {
  // get profile
  Future<Either<ApiError, UserEntity>> getUserProfile();
  Future<Either<ApiError, UserEntity>> updateUserProfile({
    required Map<String, dynamic> data,
  });
  Future<Either<ApiError, String>> shareProfileLink();

  Future<Either<ApiError, List<EventModel>>> getCreatedEvents();
}
