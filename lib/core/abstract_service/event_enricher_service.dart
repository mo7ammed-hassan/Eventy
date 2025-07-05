import 'package:eventy/features/personalization/data/datasources/profile_remote_data_souces.dart';
import 'package:eventy/features/personalization/data/mappers/user_mappers.dart';
import 'package:eventy/features/personalization/data/models/user_model.dart';
import 'package:eventy/features/user_events/data/mapper/event_mapper.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';

abstract class EventEnricherService {
  Future<List<EventEntity>> enrichEventsWithUsers({
    required List<EventModel> events,
  });
}

class EventEnricherServiceImpl implements EventEnricherService {
  final ProfileRemoteDataSource profileRemoteDataSource;

  EventEnricherServiceImpl(this.profileRemoteDataSource);

  @override
  Future<List<EventEntity>> enrichEventsWithUsers({
    required List<EventModel> events,
  }) async {
    final Set<String?> uniqueUserIds = events
        .map((e) => e.host)
        .whereType<String>()
        .toSet();

    final userFuture = uniqueUserIds.map((userId) async {
      try {
        final UserModel user = await profileRemoteDataSource.getUserProfile(
          userId: userId,
        );
        return MapEntry(userId, user);
      } catch (e) {
        return null;
      }
    });

    final userEntries = await Future.wait(userFuture);

    final userMap = {
      for (final entry in userEntries)
        if (entry != null) entry.key: entry.value,
    };

    final eventWithHost = events.map((event) {
      final user = userMap[event.host];
      return event.toEntity().copyWith(user: user?.toEntity());
    }).toList();

    return eventWithHost;
  }
}
