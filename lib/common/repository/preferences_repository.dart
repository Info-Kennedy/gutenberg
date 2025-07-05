import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferencesRepository {
  final FlutterSecureStorage _secureStorage;

  PreferencesRepository({FlutterSecureStorage? secureStorage}) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Future<void> savePreference(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getPreference(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> removePreference(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> removeAllPreference() async {
    await _secureStorage.deleteAll();
  }

  Future<Map<String, String>> getAllPreferences() async {
    return await _secureStorage.readAll();
  }
}
