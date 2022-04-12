import 'dart:convert';
import 'dart:async';

import 'package:dia_vision/app/shared/local_storage/i_local_storage.dart';
import 'package:dia_vision/app/model/theme_params.dart';

class ThemeParmasPreferences {
  final ILocalStorage _storage;
  final String _themeParams = "themeParams";

  ThemeParmasPreferences(this._storage);

  Future<bool> setThemeParams(ThemeParams themeParams) =>
      _storage.setString(_themeParams, json.encode(themeParams.toJson()));

  Future<ThemeParams?> getThemeParams() =>
      _storage.getString(_themeParams).then(
            (jsonPref) => jsonPref != null
                ? ThemeParams.fromJson(json.decode(jsonPref))
                : null,
          );

  Future<bool> clear() => _storage.remove(_themeParams);
}
