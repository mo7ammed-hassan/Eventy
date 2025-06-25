import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/get_pending_events_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/base_events_cubit.dart';

class PendingEventsCubit extends BaseEventsCubit {
  final GetPendingEventsUsecase getPendingEventsUsecase;

  PendingEventsCubit({required this.getPendingEventsUsecase}) : super();

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents() async {
    return await getPendingEventsUsecase.call(page: page, limit: limit);
  }

  @override
  Future<void> onLoadMore() {
    return getEventsList(isLoadMore: true);
  }

  @override
  searchEvents({required String query}) {
    return eventsList
        .where(
          (event) => event.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
