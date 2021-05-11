import 'package:dia_vision/app/shared/preferences/medication_notify_preferences.dart';
import 'package:dia_vision/app/model/medication_notify.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mobx/mobx.dart';

part 'medication_widget_controller.g.dart';

class MedicationsWidgetController = _MedicationsWidgetControllerBase
    with _$MedicationsWidgetController;

abstract class _MedicationsWidgetControllerBase with Store {
  final MedicationNotifyPreferences _medicationNotifyPreferences;
  final AwesomeNotifications _awesomeNotifications;

  _MedicationsWidgetControllerBase(
    this._medicationNotifyPreferences,
    this._awesomeNotifications,
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
        for (var i = 0; i < medicationNotify.horarios.length; i++) {
          await createNotification(
            medicationNotify.objectId.hashCode + i,
            medicationNotify.title,
            medicationNotify.body,
            medicationNotify.getCronHorario(i, intTempoLembrete),
          );
        }
        final result = await _medicationNotifyPreferences.setMedicationNotify(
            medicationNotify.objectId, medicationNotify);
        if (result == true) {
          medication = medicationNotify;
          onSuccess(ENABLE_NOTIFICATION_SUCCESS);
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
        for (var i = 0; i < medication.horarios.length; i++) {
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
