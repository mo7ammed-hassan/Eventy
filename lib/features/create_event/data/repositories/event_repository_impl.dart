import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/error_handler.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/data/datasources/event_remote_data_source.dart';
import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';
import 'package:eventy/features/user_events/data/mapper/event_mapper.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

class EventRepositoryImpl extends EventRepository {
  final EventRemoteDataSource _remoteDataSource;

  EventRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<EventEntity>>> getAllEvents() async {
    try {
      final result = await _remoteDataSource.getAllEvents();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }
}
