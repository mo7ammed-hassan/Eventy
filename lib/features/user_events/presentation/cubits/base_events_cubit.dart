import 'package:dartz/dartz.dart';
import 'package:eventy/core/errors/failure.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/cubits/base_events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseEventsCubit extends Cubit<BaseEventsState> {
  BaseEventsCubit() : super(BaseEventInitial());

  /// --- Method for fetching events ---
  Future<Either<Failure, List<EventEntity>>> getEvents();

  /// --- Search events by title ---
  List<EventEntity> searchEvents({required String query});

  final List<EventEntity> eventsList = [];
  int page = 1;
  int limit = 15;
  bool hasMore = true;
  bool _isLoading = false;

  Future<void> getEventsList({bool isLoadMore = false}) async {
    if (eventsList.isNotEmpty && !isLoadMore) {
      return;
    }

    if (!hasMore && isLoadMore) return;

    if (_isLoading) return;

    _isLoading = true;

    if (eventsList.isEmpty) {
      if (!isClosed) emit(BaseEventLoading());
    }

    final result = await getEvents();

    result.fold(
      (error) {
        hasMore = false;
        if (!isClosed) emit(BaseEventError(error.message));
      },
      (events) {
        if (events.isEmpty) {
          hasMore = false;
        }

        eventsList.addAll(events);
        page++;

        if (!isClosed) {
          emit(BaseEventLoaded(List.of(eventsList), isLoadMore, hasMore));
        }
      },
    );
    _isLoading = false;
  }

  Future<void> onLoadMore() async {
    await getEventsList(isLoadMore: true);
  }

  void searchEventsByTitle({required String query}) {
    final filterList = searchEvents(query: query);
    if (!isClosed) emit(BaseEventLoaded(filterList, false, false));
  }

  Future<void> onRefresh() async {
    hasMore = true;
    page = 1;
    eventsList.clear();
    if (!isClosed) emit(BaseEventLoading());
    await getEventsList();
  }
}
