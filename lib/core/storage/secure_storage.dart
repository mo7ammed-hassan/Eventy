import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async =>
      await _storage.read(key: 'access_token');
  Future<String?> getRefreshToken() async =>
      await _storage.read(key: 'refresh_token');

  Future<String?> getUserId() async => await _storage.read(key: 'user_id');

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> saveUserId(String userId) async {
    await _storage.write(key: 'user_id', value: userId);
  }

  Future<void> deleteAllTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: 'user_id');
  }

  Future<void> saveToken({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<dynamic>? read({required String key}) async {
    await _storage.read(key: key);
  }
}
