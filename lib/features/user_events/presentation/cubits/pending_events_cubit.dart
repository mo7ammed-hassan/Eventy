import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/get_pending_events_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_cubit.dart';

class PendingEventsCubit extends PaginatedEventsCubit {
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

  // Future<void> deleteEvent({required String eventId}) async {
  //   try {
  //     await getIt<ManageUserEventsRepository>().deleteEvent(eventId: eventId);
  //     eventsList.removeWhere((e) => e.id == eventId);
  //     emit(BaseEventLoaded(List.of(eventsList), false, hasMore));
  //     Loaders.customToast(message: 'Event deleted successfully');
  //   } catch (e) {
  //     Loaders.customToast(message: 'Failed to delete event');
  //   }
  // }
}
