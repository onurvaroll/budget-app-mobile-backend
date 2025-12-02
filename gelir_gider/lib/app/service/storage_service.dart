import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageKeys {
  static const String userToken = 'userToken';
  static const String themeMode = 'themeMode';
}

class StorageService extends GetxController {
  SharedPreferences? _prefs;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<StorageService> init() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
    return this;
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }

  Future<void> setValue<T>(String key, T value) async {
    await _ensureInitialized();
    try {
      if (value is String) {
        await _prefs!.setString(key, value);
      } else if (value is int) {
        await _prefs!.setInt(key, value);
      } else if (value is double) {
        await _prefs!.setDouble(key, value);
      } else if (value is bool) {
        await _prefs!.setBool(key, value);
      } else if (value is List<String>) {
        await _prefs!.setStringList(key, value);
      } else {
        throw Exception("Unsupported value type");
      }
    } catch (e) {
      print("Error setting value for key $key: $e");
    }
  }

  T? getValue<T>(String key) {
    if (!_isInitialized || _prefs == null) {
      print("StorageService not initialized yet");
      return null;
    }
    try {
      if (T == String) {
        return _prefs!.getString(key) as T?;
      } else if (T == int) {
        return _prefs!.getInt(key) as T?;
      } else if (T == double) {
        return _prefs!.getDouble(key) as T?;
      } else if (T == bool) {
        return _prefs!.getBool(key) as T?;
      } else if (T == List<String>) {
        return _prefs!.getStringList(key) as T?;
      } else {
        throw Exception("Unsupported value type");
      }
    } catch (e) {
      print("Error getting value for key $key: $e");
      return null;
    }
  }

  Future<bool> removeValue(String key) async {
    await _ensureInitialized();
    try {
      return await _prefs!.remove(key);
    } catch (e) {
      print("Error removing value for key $key: $e");
      return false;
    }
  }

  Future<bool> clearStorage() async {
    await _ensureInitialized();
    try {
      return await _prefs!.clear();
    } catch (e) {
      print("Error clearing storage: $e");
      return false;
    }
  }

  bool hasKey(String key) {
    if (!_isInitialized || _prefs == null) return false;
    return _prefs!.containsKey(key);
  }

  T getValueorDefault<T>(String key, T defaultValue) {
    final value = getValue<T>(key);
    return value ?? defaultValue;
  }

  Map<String, dynamic> getAllValues() {
    if (!_isInitialized || _prefs == null) return {};
    final keys = _prefs!.getKeys();
    final Map<String, dynamic> allValues = {};
    for (var key in keys) {
      allValues[key] = _prefs!.get(key);
    }
    return allValues;
  }
}
