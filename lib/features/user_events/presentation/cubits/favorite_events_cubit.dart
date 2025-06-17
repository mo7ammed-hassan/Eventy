import 'package:dartz/dartz.dart';
import 'package:eventy/core/api/api_error.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/usecases/get_favorite_events_usecase.dart';
import 'package:eventy/features/user_events/presentation/cubits/base_events_cubit.dart';

class FavoriteEventsCubit extends BaseEventsCubit {
  final GetFavoriteEventsUsecase getFavoriteEventsUsecase;

  FavoriteEventsCubit({required this.getFavoriteEventsUsecase}) : super();

  @override
  Future<Either<ApiError, List<EventEntity>>> getEvents() async {
    return await getFavoriteEventsUsecase.call();
  }
}
