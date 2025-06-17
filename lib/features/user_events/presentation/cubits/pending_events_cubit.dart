import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/get_pending_events_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/base_events_cubit.dart';

class PendingEventsCubit extends BaseEventsCubit {
  final GetPendingEventsUsecase getPendingEventsUsecase;

  PendingEventsCubit({required this.getPendingEventsUsecase}) : super();

  @override
  Future<Either<ApiError, List<EventEntity>>> getEvents() async {
    return await getPendingEventsUsecase.call();
  }
}
