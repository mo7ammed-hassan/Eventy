import 'package:eventy/features/user_events/user_events_injection.dart';
import 'package:flutter/rendering.dart';

import 'uplod_data_to_server.dart';
import 'dart:io';
import 'package:eventy/config/service_locator.dart';

Future<void> main(List<String> arguments) async {
  registerUserEventsDependencies(getIt);

  final uploader = UploadDataToServer();

  debugPrint('📤 Uploading events from data.json...');
  final hasFailures = await uploader.uploadAllEvents();

  if (hasFailures) {
    stdout.write(
      '\n⚠️ Some events failed. Do you want to retry them now? (y/n): ',
    );
    final answer = stdin.readLineSync();
    if (answer?.toLowerCase() == 'y') {
      debugPrint('\n♻️ Retrying failed events...');
      await uploader.uploadFailedOnly();
    } else {
      debugPrint('❌ Skipped retrying failed events.');
    }
  } else {
    debugPrint('✅ All events uploaded successfully.');
  }

  debugPrint('\n🎯 Script finished.');
}

/// ---- Command to run ----
/// dart run tools/upload_events_cli.dart
/// OR
/// flutter run tools/upload_events_cli.dart
