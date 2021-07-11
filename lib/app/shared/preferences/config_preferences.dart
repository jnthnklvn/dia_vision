import 'package:dia_vision/app/shared/local_storage/i_local_storage.dart';

class ConfigPreferences {
  final ILocalStorage _preferences;

  ConfigPreferences(this._preferences);

  String _kIsAppFirstRun = "isAppFirstRun";

  Future<bool> getIsAppFirstRun() => _preferences.getBool(_kIsAppFirstRun);

  Future<bool> setIsAppFirstRun(bool newValue) =>
      _preferences.setBool(_kIsAppFirstRun, newValue);
}
