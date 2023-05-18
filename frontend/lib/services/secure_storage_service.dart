import 'package:frontend/core/instances.dart';

class SecureStorageServices {
  static Future<void> putValue({
    required String key,
    required String value,
  }) async {
    await secureStorage.write(key: key, value: value);
  }

  static Future<String?> readValue({required String key}) async {
    return secureStorage.read(key: key);
  }

  static Future<void> deleleValue({required String key}) async {
    await secureStorage.delete(key: key);
  }

  static Future<bool> hasValueWithKey({required String key}) async {
    return secureStorage.containsKey(key: key);
  }

  static Future<void> clearAll() async {
    return secureStorage.deleteAll();
  }
}
