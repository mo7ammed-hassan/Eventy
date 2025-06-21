import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/cubits/base_events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseEventsCubit extends Cubit<BaseEventsState> {
  BaseEventsCubit() : super(BaseEventInitial());

  /// --- Method for fetching events ---
  Future<Either<ApiError, List<EventEntity>>> getEvents();

  final List<EventEntity> _eventsList = [];
  int page = 1;
  int limit = 15;
  bool hasMore = true;
  bool _isLoading = false;

  Future<void> getEventsList({bool isLoadMore = false}) async {
    if (!hasMore && isLoadMore) return;

    if (_isLoading) return;

    _isLoading = true;

    if (_eventsList.isEmpty) {
      emit(BaseEventLoading());
    }

    final result = await getEvents();

    result.fold(
      (error) {
        hasMore = false;
        emit(BaseEventError(error.message));
      },
      (eventList) {
        if (eventList.isEmpty) {
          hasMore = false;
        }

        _eventsList.addAll(eventList);
        page++;

        emit(BaseEventLoaded(List.of(_eventsList), isLoadMore, hasMore));
      },
    );
    _isLoading = false;
  }

  Future<void> onLoadMore() async {
    await getEventsList(isLoadMore: true);
  }

  Future<void> onRefresh() async {
    hasMore = true;
    page = 1;
    _eventsList.clear();
    emit(BaseEventLoading());
    await getEventsList();
  }
}
