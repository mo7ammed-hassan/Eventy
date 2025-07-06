import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/get_created_events_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_state.dart';

class JoinedEventsCubit extends PaginatedEventsCubit {
  final GetCreatedEventsUsecase getCreatedEventsUsecase;

  JoinedEventsCubit({required this.getCreatedEventsUsecase}) : super();

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents() async {
    return await getCreatedEventsUsecase.call(page: page, limit: limit);
  }

  @override
  Future<void> onLoadMore() {
    return getEventsList(isLoadMore: true);
  }

  @override
  List<EventEntity> searchEvents({required String query}) {
    return eventsList
        .where(
          (event) => event.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  void addJoinedEvent(EventEntity event) {
    if (!eventsList.any((e) => e.id == event.id)) {
      eventsList.add(event);
      emit(BaseEventLoaded(List.of(eventsList), false, hasMore));
    }
  }

  bool isEventJoined(String eventId) {
    return eventsList.any((event) => event.id == eventId);
  }
}
