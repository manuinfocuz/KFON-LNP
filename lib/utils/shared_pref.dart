import 'dart:convert';

import 'package:kfon_lnp/utils/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocal {
  late SharedPreferences _prefs;

  //SharedPreferencesLocal instance = SharedPreferencesLocal();

  Future<SharedPreferencesLocal> init() async {
    // Obtain shared preferences.
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  void setString(PrefKeys prefKeys, String value) {
    _prefs.setString(
      prefKeys.name,
      value,
    );
  }

  void setInt(PrefKeys prefKeys, int value) {
    _prefs.setInt(
      prefKeys.name,
      value,
    );
  }

  void setDouble(PrefKeys prefKeys, double value) {
    _prefs.setDouble(
      prefKeys.name,
      value,
    );
  }

  void setBool(PrefKeys prefKeys, bool value) {
    _prefs.setBool(
      prefKeys.name,
      value,
    );
  }

  void setSet(PrefKeys prefKeys, List<String> value) {
    _prefs.setStringList(
      prefKeys.name,
      value,
    );
  }

  void setMap(PrefKeys prefKeys, Map<String, dynamic> value) {
    _prefs.setString(
      prefKeys.name,
      json.encode(value),
    );
  }

  Future<String> getString(PrefKeys prefKeys,
      {String defaultValue = ""}) async {
    return _prefs.getString(
          prefKeys.name,
        ) ??
        defaultValue;
  }

  Future<int> getInt(PrefKeys prefKeys, {int defaultValue = 0}) async {
    return _prefs.getInt(
          prefKeys.name,
        ) ??
        defaultValue;
  }

  Future<double> getDouble(PrefKeys prefKeys,
      {double defaultValue = 0.1}) async {
    return _prefs.getDouble(
          prefKeys.name,
        ) ??
        defaultValue;
  }

  Future<bool> getBool(PrefKeys prefKeys, {bool defaultValue = false}) async {
    try {
      return _prefs.getBool(
            prefKeys.name,
          ) ??
          defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  Future<List<String>> getSet(PrefKeys prefKeys) async {
    return await _prefs.getStringList(
          prefKeys.name,
        ) ??
        [] as List<String>;
  }

  Future<Map<String, dynamic>> getMap(PrefKeys prefKeys) async {
    return _prefs.getString(
              prefKeys.name,
            ) ==
            null
        ? {}
        : json.decode(
            _prefs.getString(
              prefKeys.name,
            )!,
          );
  }

  void clear() async {
    try {
      _prefs.clear();
    } catch (e) {
      _prefs = await SharedPreferences.getInstance();
      _prefs.clear();
    }
  }
}
