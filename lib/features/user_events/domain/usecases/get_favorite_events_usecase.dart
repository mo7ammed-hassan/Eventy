import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/core/params/page_params.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/user_events_repository.dart';
import 'package:eventy/features/user_events/domain/usecases/generic_user_event_usecase.dart';

class GetFavoriteEventsUsecase
    extends
        GenericUserEventUsecase<
          Either<Failure, List<EventEntity>>,
          PageParams
        > {
  final UserEventsRepository repository;

  GetFavoriteEventsUsecase(this.repository);

  @override
  Future<Either<Failure, List<EventEntity>>> call(PageParams params) {
    return repository.getFavoriteEvents(page: params.page, limit: params.limit);
  }
}
