import 'uplod_data_to_server.dart';

void main() async {
  final uploader = UploadDataToServer();
  await uploader.uploadAllEvents();
}


/// ---- Command to run ----
/// dart tools/upload_events.dart
/// OR
/// flutter run tools/upload_events.dart
