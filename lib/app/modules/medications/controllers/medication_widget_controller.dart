import 'package:dia_vision/app/shared/preferences/medication_notify_preferences.dart';
import 'package:dia_vision/app/model/medication_notify.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mobx/mobx.dart';

part 'medication_widget_controller.g.dart';

class MedicationsWidgetController = _MedicationsWidgetControllerBase
    with _$MedicationsWidgetController;

abstract class _MedicationsWidgetControllerBase with Store {
  final MedicationNotifyPreferences _medicationNotifyPreferences;
  final AwesomeNotifications _awesomeNotifications;
  final AppController _appController;

  _MedicationsWidgetControllerBase(
    this._medicationNotifyPreferences,
    this._awesomeNotifications,
    this._appController,
  );

  @observable
  MedicationNotify medication;

  @observable
  bool isLoading = false;

  Future<void> getNotification(String objectId) async {
    isLoading = true;
    if (medication == null) {
      medication =
          await _medicationNotifyPreferences.getMedicationNotify(objectId);
    }
    isLoading = false;
  }

  Future<void> enableNotification(
      MedicationNotify medicationNotify,
      String tempoLembrete,
      Function(String) onError,
      Function(String) onSuccess) async {
    isLoading = true;
    final intTempoLembrete =
        int.tryParse(tempoLembrete?.split(' ')?.elementAt(0) ?? '10');
    try {
      if (medicationNotify.horarios != null) {
        if (medicationNotify.horarios.length > 6) {
          onError('O limite máximo de horários para notificação é 6.');
        } else {
          for (var i = 0; i < medicationNotify.horarios.length; i++) {
            await _appController.createNotification(
              medicationNotify.objectId.hashCode + i,
              medicationNotify.title,
              medicationNotify.body,
              NotificationSchedule(
                allowWhileIdle: true,
                initialDateTime: DateTime.now().toUtc(),
                crontabSchedule:
                    "0 ${medicationNotify.getCronHorario(i, intTempoLembrete)} * * ? *",
              ),
              tempoLembrete: tempoLembrete,
            );
          }
          final result = await _medicationNotifyPreferences.setMedicationNotify(
              medicationNotify.objectId, medicationNotify);
          if (result == true) {
            medication = medicationNotify;
            onSuccess(ENABLE_NOTIFICATION_SUCCESS);
          }
        }
      } else {
        onError(REGISTER_NOTIFICATION_FAIL);
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
      if (medication?.horarios != null) {
        for (var i = 0; i < 6; i++) {
          await _awesomeNotifications
              .cancelSchedule(medication.objectId.hashCode + i);
        }
      }
      final result = await _medicationNotifyPreferences
          .removeMedicationNotify(medication.objectId);
      if (result == true) {
        medication = null;
        onSuccess(DISABLE_NOTIFICATION_SUCCESS);
      } else {
        onError(DELETE_NOTIFICATION_FAIL);
      }
    } catch (e) {
      onError(DELETE_NOTIFICATION_FAIL);
    }
    isLoading = false;
  }
}
