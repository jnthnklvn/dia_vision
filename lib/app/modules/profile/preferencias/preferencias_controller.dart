import 'package:dia_vision/app/shared/preferences/preferencias_preferences.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';

import 'package:mobx/mobx.dart';

part 'preferencias_controller.g.dart';

class PreferenciasController = _PreferenciasControllerBase
    with _$PreferenciasController;

abstract class _PreferenciasControllerBase with Store, DateUtils {
  final PreferenciasPreferences _preferences;

  _PreferenciasControllerBase(this._preferences);

  @observable
  bool isLoading = false;
  @observable
  bool isDataReady = false;
  @observable
  bool alertarMedicacao = false;
  @observable
  bool alertarGlicemia = false;
  @observable
  bool alertarHipoHiperGlicemia = false;
  @observable
  String tempoLembrete = "10 min";
  @observable
  String valorMinimoGlicemia = "70";
  @observable
  String valorMaximoGlicemia = "120";
  @observable
  String horarioGlicemia;

  @action
  void setAlertarMedicacao(bool newValue) {
    alertarMedicacao = newValue;
    _preferences.setAlertarMedicacao(newValue);
  }

  @action
  void setAlertarGlicemia(bool newValue) {
    alertarGlicemia = newValue;
    _preferences.setAlertarGlicemia(newValue);
  }

  @action
  void setAlertarHipoHiperGlicemia(bool newValue) {
    alertarHipoHiperGlicemia = newValue;
    _preferences.setAlertarHipoHiperGlicemia(newValue);
  }

  @action
  void setTempoLembrete(String newValue) {
    tempoLembrete = newValue;
    _preferences.setTempoLembrete(newValue);
  }

  @action
  void setHorarioGlicemia(String newHorarioGlicemia) =>
      horarioGlicemia = newHorarioGlicemia;
  @action
  void setValorMinimoGlicemia(String newValue) =>
      valorMinimoGlicemia = newValue;
  @action
  void setValorMaximoGlicemia(String newValue) =>
      valorMaximoGlicemia = newValue;

  Future<void> getData(Function(String) onError) async {
    isDataReady = false;

    try {
      alertarMedicacao =
          await _preferences.getAlertarMedicacao() ?? alertarMedicacao;
      alertarGlicemia =
          await _preferences.getAlertarGlicemia() ?? alertarGlicemia;
      alertarHipoHiperGlicemia =
          await _preferences.getAlertarHipoHiperGlicemia() ??
              alertarHipoHiperGlicemia;
      tempoLembrete = await _preferences.getTempoLembrete() ?? tempoLembrete;
      valorMinimoGlicemia =
          await _preferences.getValorMinimoGlicemia() ?? valorMinimoGlicemia;
      valorMaximoGlicemia =
          await _preferences.getValorMaximoGlicemia() ?? valorMaximoGlicemia;
      horarioGlicemia = await _preferences.getHorarioGlicemia() ?? horarioGlicemia;
    } catch (e) {
      onError(e.toString());
    }

    isDataReady = true;
  }

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    try {
      await _preferences.setValorMaximoGlicemia(valorMaximoGlicemia);
      await _preferences.setValorMinimoGlicemia(valorMinimoGlicemia);
      await _preferences.setHorarioGlicemia(horarioGlicemia);
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
