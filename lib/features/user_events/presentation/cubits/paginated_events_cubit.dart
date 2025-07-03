import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/core/utils/helpers/mixins/pagination_mixin.dart';
import 'package:eventy/core/utils/helpers/mixins/retry_mixin.dart';
import 'package:eventy/core/utils/helpers/mixins/safe_emit_mixin.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PaginatedEventsCubit extends Cubit<PaginatedEventsState>
    with SafeEmitMixin<PaginatedEventsState>, PaginationMixin, RetryMixin {
  PaginatedEventsCubit() : super(BaseEventInitial());

  /// --- Method for fetching events ---
  Future<Either<Failure, List<EventEntity>>> getEvents();

  /// --- Search events by title ---
  List<EventEntity> searchEvents({required String query});

  final List<EventEntity> eventsList = [];

  Future<void> getEventsList({bool isLoadMore = false}) async {
    if (eventsList.isNotEmpty && !isLoadMore) {
      return;
    }

    if (!canLoadMore()) return;
    isLoading = true;

    if (eventsList.isEmpty) {
      safeEmit(BaseEventLoading());
    }

    // final result = await getEvents();
    final result = await retryEither(
      () => getEvents(),
      maxRetries: 3,
      delayBetweenRetries: Duration(seconds: 1),
      shouldRetryOnFailure: (failure) => failure is NetworkFailure,
    );

    result.fold(
      (error) {
        hasMore = false;
        safeEmit(BaseEventError(error.message));
      },
      (events) {
        if (events.isEmpty || events.length < limit) {
          hasMore = false;
          isLoadMore = false;
        }

        eventsList.addAll(events);
        increasePage();

        safeEmit(BaseEventLoaded(List.of(eventsList), isLoadMore, hasMore));
      },
    );
    isLoading = false;
  }

  Future<void> onLoadMore() async {
    await getEventsList(isLoadMore: true);
  }

  void searchEventsByTitle({required String query}) {
    final filterList = searchEvents(query: query);
    safeEmit(BaseEventLoaded(filterList, false, false));
  }

  Future<void> onRefresh() async {
    resetPagination();
    eventsList.clear();
    safeEmit(BaseEventLoading());
    await getEventsList();
  }
}
