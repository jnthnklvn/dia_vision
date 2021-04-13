import 'package:dia_vision/app/shared/local_storage/i_local_storage.dart';

class PreferenciasPreferences {
  final ILocalStorage _preferences;

  PreferenciasPreferences(this._preferences);

  String kAlertarGlicemia = "alertarGlicemia";
  String kAlertarMedicacao = "alertarMedicacao";
  String kAlertarHipoHiperGlicemia = "alertarHipoHiperGlicemia";
  String kValorMinimoGlicemia = "valorMinimoGlicemia";
  String kValorMaximoGlicemia = "valorMaximoGlicemia";
  String kTempoLembrete = "tempoLembrete";
  String kHorarioGlicemia = "horarioGlicemia";

  Future<String> getTempoLembrete() => _preferences.getString(kTempoLembrete);
  Future<String> getValorMinimoGlicemia() =>
      _preferences.getString(kValorMinimoGlicemia);
  Future<String> getValorMaximoGlicemia() =>
      _preferences.getString(kValorMaximoGlicemia);
  Future<String> getHorarioGlicemia() => _preferences.getString(kHorarioGlicemia);
  Future<bool> getAlertarMedicacao() => _preferences.getBool(kAlertarMedicacao);
  Future<bool> getAlertarGlicemia() => _preferences.getBool(kAlertarGlicemia);
  Future<bool> getAlertarHipoHiperGlicemia() =>
      _preferences.getBool(kAlertarHipoHiperGlicemia);

  Future<bool> setTempoLembrete(String newValue) =>
      _preferences.setString(kTempoLembrete, newValue);
  Future<bool> setValorMinimoGlicemia(String newValue) =>
      _preferences.setString(kValorMinimoGlicemia, newValue);
  Future<bool> setValorMaximoGlicemia(String newValue) =>
      _preferences.setString(kValorMaximoGlicemia, newValue);
  Future<bool> setHorarioGlicemia(String newValue) =>
      _preferences.setString(kHorarioGlicemia, newValue);
  Future<bool> setAlertarMedicacao(bool newValue) =>
      _preferences.setBool(kAlertarMedicacao, newValue);
  Future<bool> setAlertarGlicemia(bool newValue) =>
      _preferences.setBool(kAlertarGlicemia, newValue);
  Future<bool> setAlertarHipoHiperGlicemia(bool newValue) =>
      _preferences.setBool(kAlertarHipoHiperGlicemia, newValue);
}
