import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'i_local_storage.dart';

class LocalStorageShared implements ILocalStorage {
  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  LocalStorageShared() {
    _init();
  }

  Future<void> _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }

  @override
  Future<bool> remove(String key) async {
    var shared = await _instance.future;
    return shared.remove(key);
  }

  @override
  Future<bool> clear() async {
    var shared = await _instance.future;
    return shared.clear();
  }

  @override
  Future<bool> getBool(String key) async {
    var shared = await _instance.future;
    return shared.getBool(key);
  }

  @override
  Future<String> getString(String key) async {
    var shared = await _instance.future;
    return shared.getString(key);
  }

  @override
  Future<int> getInt(String key) async {
    var shared = await _instance.future;
    return shared.getInt(key);
  }

  @override
  Future<List<String>> getStringList(String key) async {
    var shared = await _instance.future;
    return shared.getStringList(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    var shared = await _instance.future;
    return shared.setBool(key, value);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    var shared = await _instance.future;
    return shared.setInt(key, value);
  }

  @override
  Future<bool> setString(String key, String value) async {
    var shared = await _instance.future;
    return shared.setString(key, value);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    var shared = await _instance.future;
    return shared.setStringList(key, value);
  }
}
