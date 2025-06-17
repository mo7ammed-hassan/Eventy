import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/cubits/base_events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseEventsCubit extends Cubit<BaseEventsState> {
  BaseEventsCubit() : super(BaseEventInitial());

  /// --- Method for fetching events ---
  Future<Either<ApiError, List<EventEntity>>> getEvents();
  bool _isFetched = false;

  Future<void> getEventsList() async {
    if (_isFetched) return;
    emit(BaseEventLoading());

    final result = await getEvents();

    result.fold((error) => emit(BaseEventError(error.message)), (eventList) {
      _isFetched = true;
      emit(BaseEventLoaded(eventList));
    });
  }

  Future<void> onRefresh() async {
    emit(BaseEventLoading());
    await getEvents();
  }
}
