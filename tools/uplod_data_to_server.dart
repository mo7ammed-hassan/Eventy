import 'dart:convert';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/create_event/data/mapper/create_event_mapper.dart';
import 'package:eventy/features/create_event/data/models/create_event_model.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class UploadDataToServer {
  final ManageUserEventsRepository _repository =
      getIt<ManageUserEventsRepository>();

  /// Load events from local JSON file
  Future<List<CreateEventModel>> _loadEventsFromJson() async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    final List<dynamic> jsonData = jsonMap['events'];

    final events = jsonData
        .cast<Map<String, dynamic>>()
        .map(CreateEventModel.fromJson)
        .toList();

    return events;
  }

  /// Upload a single event
  Future<void> _uploadEvent(CreateEventEntity event) async {
    await _repository.createEvent(event: event);
  }

  /// Upload all events one by one
  Future<void> uploadAllEvents() async {
    final events = await _loadEventsFromJson();
    final int total = events.length;
    int successCount = 0;
    int failureCount = 0;

    debugPrint('📦 Starting upload of $total events...');

    for (int i = 0; i < total; i++) {
      final event = events[i];
      try {
        await _uploadEvent(event.toEntity());
        successCount++;
        debugPrint('[$i/$total] ✅ Uploaded: ${event.name}');
      } catch (e) {
        failureCount++;
        debugPrint('[$i/$total] ❌ Failed: ${event.name} - $e');
      }

      await Future.delayed(const Duration(milliseconds: 300));
    }

    debugPrint('------------------------------------------');
    debugPrint('🎉 Upload complete');
    debugPrint('📊 Total events: $total');
    debugPrint('✅ Successfully uploaded: $successCount');
    debugPrint('❌ Failed uploads: $failureCount');
    debugPrint('------------------------------------------');
  }
}
