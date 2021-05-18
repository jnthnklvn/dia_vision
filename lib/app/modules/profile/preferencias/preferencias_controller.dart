import 'package:dia_vision/app/shared/preferences/preferencias_preferences.dart';
import 'package:dia_vision/app/shared/utils/string_utils.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mobx/mobx.dart';

part 'preferencias_controller.g.dart';

class PreferenciasController = _PreferenciasControllerBase
    with _$PreferenciasController;

abstract class _PreferenciasControllerBase with Store {
  final AwesomeNotifications _awesomeNotifications;
  final PreferenciasPreferences _preferences;

  _PreferenciasControllerBase(this._preferences, this._awesomeNotifications);

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
  @observable
  List<String> horarios = List<String>();
  String horario;
  final idGlicemia = "glicemia".hashCode;

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
  void addHorario() {
    horarios.add(horario);
    horarios = horarios.asObservable();
  }

  @action
  void removeHorario(String h) {
    horarios.remove(h);
    horarios = horarios.asObservable();
  }

  @action
  void setHorario(String newHorario) => horario = newHorario;
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
      horarios = await _preferences.getHorariosGlicemia() ?? horarios;
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
      await _preferences.setHorariosGlicemia(horarios);
      enableNotification(onError);
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }

    isLoading = false;
  }

  Future<void> enableNotification(Function(String) onError) async {
    isLoading = true;
    final intTempoLembrete =
        int.tryParse(tempoLembrete?.split(' ')?.elementAt(0) ?? '10');
    try {
      if (horarios.isNotEmpty == true && alertarGlicemia) {
        for (var i = 0; i < horarios.length; i++) {
          await createNotification(
            idGlicemia,
            "${tempoLembrete ?? '10 min'} $TO_GLICEMY_REGISTER_TIME",
            GLICEMY_REGISTER_TIME,
            getCronHorario(i, horarios, intTempoLembrete),
          );
        }
      }
    } catch (e) {
      onError(REGISTER_NOTIFICATION_FAIL);
    }
    isLoading = false;
  }

  Future<void> disableNotification(
      Function(String) onError, Function(String) onSuccess) async {
    isLoading = true;
    try {
      if (horarios.isNotEmpty == true && !alertarGlicemia) {
        for (var i = 0; i < horarios.length; i++) {
          await _awesomeNotifications.cancelSchedule(idGlicemia + i);
        }
        onSuccess(DISABLE_NOTIFICATION_SUCCESS);
      }
    } catch (e) {
      onError(DELETE_NOTIFICATION_FAIL);
    }
    isLoading = false;
  }

  Future<bool> createNotification(
      int id, String title, String body, String horario) {
    return _awesomeNotifications.createNotification(
      schedule: NotificationSchedule(
        allowWhileIdle: true,
        initialDateTime: DateTime.now().toUtc(),
        crontabSchedule: "0 $horario * * ? *",
      ),
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }
}
