import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  AppStorage._();

  static SharedPreferences? _storage;

  static AppStorage get instance => AppStorage._();

  static Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
  }

  static Future<void> setValue(String key, bool value) async {
    await _storage?.setBool(key, value);
  }

  static Future<void> setString(String key, String value) async {
    await _storage?.setString(key, value);
  }

  static bool? getBool(String key) => _storage?.getBool(key) ?? false;

  static String getString(String key) => _storage?.getString(key) ?? '';

  static Future<void> remove(String key) async {
    await _storage?.remove(key);
  }

  static Future<void> clear() async => await _storage?.clear();
}
