import 'dart:convert';
import 'dart:io';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/create_event/data/mapper/create_event_mapper.dart';
import 'package:eventy/features/create_event/data/models/create_event_model.dart';
import 'package:eventy/features/user_events/domain/repositories/manage_user_events_repository.dart';
import 'package:flutter/foundation.dart';

class UploadDataToServer {
  final ManageUserEventsRepository _repository =
      getIt<ManageUserEventsRepository>();

  final String dataFile = 'assets/data.json';
  final String failedFile = 'assets/failed_events.json';

  Future<List<CreateEventModel>> _loadEventsFromFile(String path) async {
    final file = File(path);
    final jsonString = await file.readAsString();
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> jsonData = jsonMap['events'];
    return jsonData
        .cast<Map<String, dynamic>>()
        .map(CreateEventModel.fromJson)
        .toList();
  }

  Future<void> _saveFailedEvents(List<CreateEventModel> failed) async {
    final file = File(failedFile);
    final json = jsonEncode({'events': failed.map((e) => e.toJson()).toList()});
    await file.writeAsString(json);
    debugPrint('💾 Saved ${failed.length} failed events to $failedFile');
  }

  Future<void> _uploadEventWithRetry(
    CreateEventModel event, {
    int maxRetries = 3,
  }) async {
    int attempt = 0;
    while (attempt < maxRetries) {
      try {
        await _repository.createEvent(event: event.toEntity());
        return;
      } catch (_) {
        attempt++;
        await Future.delayed(const Duration(milliseconds: 300));
      }
    }
    throw Exception('Max retries reached for: ${event.name}');
  }

  Future<bool> _upload(List<CreateEventModel> events) async {
    int success = 0;
    int failure = 0;
    final failed = <CreateEventModel>[];

    debugPrint('📦 Uploading ${events.length} events...');

    for (final event in events) {
      try {
        await _uploadEventWithRetry(event);
        success++;
        debugPrint('✅ Uploaded: ${event.name}');
      } catch (e) {
        failure++;
        failed.add(event);
        debugPrint('❌ Failed: ${event.name}');
      }
    }

    debugPrint('------------------------------');
    debugPrint('📊 Total: ${events.length}');
    debugPrint('✅ Success: $success');
    debugPrint('❌ Failed: $failure');
    debugPrint('------------------------------');

    if (failed.isNotEmpty) {
      await _saveFailedEvents(failed);
      return true; 
    }

    final failedFileFile = File(failedFile);
    if (await failedFileFile.exists()) {
      await failedFileFile.delete();
    }

    return false;
  }

  Future<bool> uploadAllEvents() async {
    final events = await _loadEventsFromFile(dataFile);
    return await _upload(events);
  }

  Future<void> uploadFailedOnly() async {
    final file = File(failedFile);
    if (!await file.exists()) {
      debugPrint('📂 No failed events file found.');
      return;
    }

    final events = await _loadEventsFromFile(failedFile);
    debugPrint('♻️ Retrying ${events.length} failed events...');
    await _upload(events);
  }
}
