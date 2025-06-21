import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  late SharedPreferences _storage;

  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
  }

  Future<void> setBool(String key, bool value) async {
    await _storage.setBool(key, value);
  }

  Future<void> setString(String key, String value) async {
    await _storage.setString(key, value);
  }

  bool getBool(String key) => _storage.getBool(key) ?? false;

  String getString(String key) => _storage.getString(key) ?? '';

  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  Future<void> clear() async => await _storage.clear();
}
