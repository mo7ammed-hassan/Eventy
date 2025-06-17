import 'package:flutter/services.dart';

class ShareHelper {
  static const MethodChannel _channel = MethodChannel('custom_share');

  static Future<void> shareContent(String text) async {
    try {
      await _channel.invokeMethod('share', {"text": text});
    } catch (e) {
      rethrow;
    }
  }
}
