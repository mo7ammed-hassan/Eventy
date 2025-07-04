import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';
import 'package:eventy/features/personalization/domain/entities/user_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserEntity>> getUserProfile();

  Future<Either<Failure, UserEntity>> updateUserProfile({
    required Map<String, dynamic> data,
  });
  Future<Either<Failure, String>> shareProfileLink();

  Future<Either<Failure, List<EventModel>>> getCreatedEvents();

  Future<Either<Failure, UserEntity>> getUserProfileById({required String id});
}
