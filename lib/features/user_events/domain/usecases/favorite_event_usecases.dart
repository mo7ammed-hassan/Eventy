import 'package:eventy/features/user_events/domain/usecases/add_event_to_favorite_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/get_favorite_events_usecase.dart';
import 'package:eventy/features/user_events/domain/usecases/remove_event_from_favorite_usecase.dart';

/// A wrapper class that groups all use cases related to favorite events
class FavoriteEventUseCases {
  final GetFavoriteEventsUsecase get;
  final AddEventToFavoriteUsecase add;
  final RemoveEventFromFavoriteUsecase remove;

  FavoriteEventUseCases({
    required this.get,
    required this.add,
    required this.remove,
  });
}
