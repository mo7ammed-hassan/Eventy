import 'package:dartz/dartz.dart';
import 'package:eventy/core/abstract_service/event_enricher_service.dart';
import 'package:eventy/core/errors/error_handler.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/create_event/data/datasources/event_remote_data_source.dart';
import 'package:eventy/features/create_event/domain/repositories/event_repository.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

class EventRepositoryImpl extends EventRepository {
  final EventRemoteDataSource _remoteDataSource;
  final EventEnricherService _eventEnricherService;

  EventRepositoryImpl(this._remoteDataSource, this._eventEnricherService);

  @override
  Future<Either<Failure, List<EventEntity>>> getAllEvents({
    int limit = 15,
    int page = 1,
  }) async {
    try {
      final result = await _remoteDataSource.getAllEvents(
        limit: limit,
        page: page,
      );

      final eventWithHost = await _eventEnricherService.enrichEventsWithUsers(
        events: result,
      );

      return Right(eventWithHost);
    } catch (e) {
      final error = ErrorHandler.handle(e);
      return Left(mapErrorToFailure(error));
    }
  }
}
