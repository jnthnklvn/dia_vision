import 'package:dia_vision/app/shared/local_storage/i_local_storage.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';

import 'package:mobx/mobx.dart';

part 'preferencias_controller.g.dart';

class PreferenciasController = _PreferenciasControllerBase
    with _$PreferenciasController;

abstract class _PreferenciasControllerBase with Store, DateUtils {
  final ILocalStorage _preferences;

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

  String kAlertarGlicemia = "alertarGlicemia";
  String kAlertarMedicacao = "alertarMedicacao";
  String kAlertarHipoHiperGlicemia = "alertarHipoHiperGlicemia";
  String kValorMinimoGlicemia = "valorMinimoGlicemia";
  String kValorMaximoGlicemia = "valorMaximoGlicemia";
  String kTempoLembrete = "tempoLembrete";

  @action
  void setAlertarMedicacao(bool newValue) {
    alertarMedicacao = newValue;
    _preferences.setBool(kAlertarMedicacao, newValue);
  }

  @action
  void setAlertarGlicemia(bool newValue) {
    alertarGlicemia = newValue;
    _preferences.setBool(kAlertarGlicemia, newValue);
  }

  @action
  void setAlertarHipoHiperGlicemia(bool newValue) {
    alertarHipoHiperGlicemia = newValue;
    _preferences.setBool(kAlertarHipoHiperGlicemia, newValue);
  }

  @action
  void setTempoLembrete(String newValue) {
    tempoLembrete = newValue;
    _preferences.setString(kTempoLembrete, newValue);
  }

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
          await _preferences.getBool(kAlertarMedicacao) ?? alertarMedicacao;
      alertarGlicemia =
          await _preferences.getBool(kAlertarGlicemia) ?? alertarGlicemia;
      alertarHipoHiperGlicemia =
          await _preferences.getBool(kAlertarHipoHiperGlicemia) ??
              alertarHipoHiperGlicemia;
      tempoLembrete =
          await _preferences.getString(kTempoLembrete) ?? tempoLembrete;
      valorMinimoGlicemia =
          await _preferences.getString(kValorMinimoGlicemia) ??
              valorMinimoGlicemia;
      valorMaximoGlicemia =
          await _preferences.getString(kValorMaximoGlicemia) ??
              valorMaximoGlicemia;
    } catch (e) {
      onError(e.toString());
    }

    isDataReady = true;
  }

  Future<void> save(Function(String) onError, void Function() onSuccess) async {
    isLoading = true;

    try {
      await _preferences.setString(kValorMaximoGlicemia, valorMaximoGlicemia);
      await _preferences.setString(kValorMinimoGlicemia, valorMinimoGlicemia);
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }
}
