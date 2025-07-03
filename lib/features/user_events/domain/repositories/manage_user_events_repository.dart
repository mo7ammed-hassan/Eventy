import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';

abstract class ManageUserEventsRepository {
  Future<Either<Failure, Unit>> joinEvent({required String eventId});

  Future<Either<Failure, Unit>> updateEvent({required String eventId});

  Future<Either<Failure, Unit>> deleteEvent({required String eventId});

  Future<Either<Failure, Unit>> removeFromFavorite({required String eventId});

  Future<Either<Failure, Unit>> addToFavorite({required String eventId});
}
