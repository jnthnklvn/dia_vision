import 'package:dia_vision/app/modules/medications/controllers/medication_widget_controller.dart';
import 'package:dia_vision/app/modules/medications/controllers/medications_controller.dart';
import 'package:dia_vision/app/shared/preferences/medication_notify_preferences.dart';
import 'package:dia_vision/app/modules/medications/utils/medication_utils.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart' as Dt;
import 'package:dia_vision/app/model/medication_notify.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class MedicationWidget extends StatelessWidget
    with Dt.DateUtils, MedicationUtils {
  final MedicacaoPrescrita _medicacaoPrescrita;
  final _controller = MedicationsWidgetController(
    Modular.get<MedicationNotifyPreferences>(),
    Modular.get<AwesomeNotifications>(),
  );
  final _medicationsController = Modular.get<MedicationsController>();
  final Function(String) onError;
  final Function(String) onSuccess;

  MedicationWidget(this._medicacaoPrescrita, this.onError, this.onSuccess);

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  String getFullString(String fieldName, String text) {
    if (text?.isNotEmpty != true) return null;
    return "$fieldName: $text";
  }

  @override
  Widget build(BuildContext context) {
    _controller.getNotification(_medicacaoPrescrita.objectId);
    final subtitleContents = [
      getFullString("Dosagem", _medicacaoPrescrita.dosagem?.toString()),
      getFullString("Posologia", getPosologia(_medicacaoPrescrita.posologia)),
      _medicacaoPrescrita.posologia == 0
          ? getFullString("Horários", _medicacaoPrescrita.horarios)
          : getFullString(
              "Horário inicial",
              _medicacaoPrescrita.horarioInicial,
            ),
      getFullString(
          "Data inicial", getDataBrFromDate(_medicacaoPrescrita.dataInicial)),
      getFullString(
          "Data final", getDataBrFromDate(_medicacaoPrescrita.dataFinal)),
      getFullString("Médico Prescritor", _medicacaoPrescrita.medicoPrescritor),
      getFullString(
          "Efeitos colaterais", _medicacaoPrescrita.efeitosColaterais),
    ];
    subtitleContents.removeWhere((e) => e == null);

    String stringToSpeak = subtitleContents.toString();
    stringToSpeak = stringToSpeak.length > 1
        ? stringToSpeak.substring(1, stringToSpeak.length - 1)
        : stringToSpeak;

    return InkWell(
      onTap: () => Modular.to.pushNamed(
        "${medications.routeName}/$REGISTER",
        arguments: _medicacaoPrescrita,
      ),
      onLongPress: () => Modular.get<FlutterTts>().speak(
        getFullString("Nome", _medicacaoPrescrita.nome) + stringToSpeak,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorUtils.colors[
                  _medicacaoPrescrita.nome.hashCode % ColorUtils.colors.length]
              .withOpacity(0.5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        margin: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kSecondaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  _medicacaoPrescrita.nome,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                trailing: Observer(builder: (_) {
                  if (_controller.isLoading)
                    return Container(
                      height: 38,
                      width: 38,
                      child: CircularProgressIndicator(),
                    );
                  final isNoticationOn = _controller.medication != null;
                  return InkWell(
                    onLongPress: () => _speak(
                        "$BUTTON ${(isNoticationOn ? '$DISABLE' : '$ENABLE')} $NOTIFICATION"),
                    child: Icon(
                      isNoticationOn
                          ? Icons.notifications_off_outlined
                          : Icons.notifications_active_outlined,
                      size: 38,
                      color:
                          isNoticationOn ? Colors.red[900] : Colors.green[900],
                    ),
                    onTap: () {
                      if (isNoticationOn) {
                        _controller.disableNotification(onError, onSuccess);
                      } else {
                        final medicationNotify = MedicationNotify(
                          objectId: _medicacaoPrescrita.objectId,
                          horarios: _medicacaoPrescrita.getHorarios(),
                          title:
                              "Horário de medicação ${_medicacaoPrescrita.nome ?? ''}",
                          body:
                              "${_medicationsController.tempoLembrete ?? '10 min'} para horário da medicação ${_medicacaoPrescrita.nome ?? ''}",
                        );

                        _controller.enableNotification(
                            medicationNotify,
                            _medicationsController.tempoLembrete,
                            onError,
                            onSuccess);
                      }
                    },
                  );
                }),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: subtitleContents
                      .map((e) => buildSubtitlesText(e))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSubtitlesText(String text) {
    return Text(
      text,
      maxLines: 2,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
    );
  }
}
