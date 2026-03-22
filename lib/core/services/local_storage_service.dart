import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  Future<void> init();
  Future<bool> setString(String key, String value);
  String? getString(String key);
  Future<bool> setBool(String key, bool value);
  bool? getBool(String key);
  Future<bool> setInt(String key, int value);
  int? getInt(String key);
  Future<bool> remove(String key);
  Future<bool> clear();
}

class LocalStorageServiceImpl implements LocalStorageService {
  SharedPreferences? _prefs;
  SharedPreferences get prefs => _prefs!;

  @override
  Future<void> init() async { _prefs = await SharedPreferences.getInstance(); }
  @override
  Future<bool> setString(String key, String value) => prefs.setString(key, value);
  @override
  String? getString(String key) => prefs.getString(key);
  @override
  Future<bool> setBool(String key, bool value) => prefs.setBool(key, value);
  @override
  bool? getBool(String key) => prefs.getBool(key);
  @override
  Future<bool> setInt(String key, int value) => prefs.setInt(key, value);
  @override
  int? getInt(String key) => prefs.getInt(key);
  @override
  Future<bool> remove(String key) => prefs.remove(key);
  @override
  Future<bool> clear() => prefs.clear();
}
