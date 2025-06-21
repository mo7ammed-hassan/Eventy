import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/get_created_events_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/base_events_cubit.dart';

class CreatedEventsCubit extends BaseEventsCubit {
  final GetCreatedEventsUsecase getCreatedEventsUsecase;

  CreatedEventsCubit({required this.getCreatedEventsUsecase}) : super();

  @override
  Future<Either<ApiError, List<EventEntity>>> getEvents() async {
    return await getCreatedEventsUsecase.call(page: page, limit: limit);
  }

  @override
  Future<void> onLoadMore() {
    return getEventsList(isLoadMore: true);
  }
}
