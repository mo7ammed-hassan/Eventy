import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/error_handler.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/data/datasources/manage_user_events_remote_datasource.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';

class ManageUserEventRepositoryImpl implements ManageUserEventsRepository {
  final ManageUserEventsRemoteDataSource remoteDataSource;

  ManageUserEventRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Unit>> addToFavorite({required String eventId}) async {
    try {
      await remoteDataSource.addToFavorite(eventId: eventId);
      return const Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteEvent({required String eventId}) async {
    try {
      await remoteDataSource.deleteEvent(eventId: eventId);
      return const Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> joinEvent({required String eventId}) async {
    try {
      await remoteDataSource.joinEvent(eventId: eventId);
      return const Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromFavorite({
    required String eventId,
  }) async {
    try {
      await remoteDataSource.removeFromFavorite(eventId: eventId);
      return const Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateEvent({required String eventId}) async {
    try {
      await remoteDataSource.updateEvent(eventId: eventId);
      return const Right(unit);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }
}
