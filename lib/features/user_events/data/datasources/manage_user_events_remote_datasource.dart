abstract class ManageUserEventsRemoteDataSource {
  Future<void> createEvent({required String eventId});

  Future<void> joinEvent({required String eventId});

  Future<void> updateEvent({required String eventId});

  Future<void> deleteEvent({required String eventId});

  Future<void> removeFromFavorite({required String eventId});
}


