import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/core/params/page_params.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/favorite_event_usecases.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_state.dart';

class FavoriteEventsCubit extends PaginatedEventsCubit {
  final FavoriteEventUseCases _favoriteEventUseCases;

  FavoriteEventsCubit(this._favoriteEventUseCases) : super();

  @override
  Future<Either<Failure, List<EventEntity>>> getEvents() async {
    return await _favoriteEventUseCases.get(
      PageParams(page: page, limit: limit),
    );
  }

  Future<void> toggleFavorite({required EventEntity event}) async {
    final isAlreadyFavorite = eventsList.any((e) => e.id == event.id);
    if (isAlreadyFavorite) {
      await removeEventFromFavorite(eventId: event.id);
    } else {
      await addEventToFavorite(event: event);
    }
  }

  Future<Either<Failure, Unit>> addEventToFavorite({
    required EventEntity event,
  }) async {
    eventsList.add(event);
    safeEmit(BaseEventLoaded(List.of(eventsList), false, hasMore));
    Loaders.customToast(message: 'Adding to favorites');

    final result = await _favoriteEventUseCases.add(event.id);
    return result.fold((failure) {
      // Rollback
      eventsList.removeWhere((e) => e.id == event.id);
      safeEmit(BaseEventLoaded(List.of(eventsList), false, hasMore));

      Loaders.customToast(message: 'Failed to add to favorites');
      return Left(failure);
    }, (r) => Right(unit));
  }

  Future<Either<Failure, Unit>> removeEventFromFavorite({
    required String eventId,
  }) async {
    final removedEvent = eventsList.firstWhere(
      (e) => e.id == eventId,
      orElse: () => EventEntity.empty(),
    );

    eventsList.removeWhere((e) => e.id == eventId);
    safeEmit(BaseEventLoaded(List.of(eventsList), false, hasMore));
    Loaders.customToast(message: 'Removing from favorites');

    final result = await _favoriteEventUseCases.remove(eventId);
    return result.fold((failure) {
      // Rollback
      if (removedEvent != EventEntity.empty()) {
        eventsList.add(removedEvent);
        safeEmit(BaseEventLoaded(List.of(eventsList), false, hasMore));
      }

      Loaders.customToast(message: 'Failed to remove from favorites');
      return Left(failure);
    }, (r) => Right(unit));
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

  bool isFavorite({required EventEntity event}) {
    return eventsList.any((e) => e.id == event.id);
  }
}
