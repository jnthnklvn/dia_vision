import 'package:dia_vision/app/shared/components/text_field_container.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

import 'choose_dialog.dart';

class ContainerFieldHorarios extends StatelessWidget with DateUtils {
  const ContainerFieldHorarios({
    @required this.context,
    @required this.horarios,
    @required this.setHorario,
    @required this.addHorario,
    @required this.removeHorario,
    @required this.horario,
  });

  final void Function(String) setHorario;
  final void Function() addHorario;
  final void Function(String) removeHorario;
  final List<String> horarios;
  final BuildContext context;
  final String horario;

  Future<dynamic> _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  Future showTimePickerDialog() {
    return Navigator.of(context).push(
      showPicker(
        context: context,
        cancelText: CANCELL,
        okText: ADD,
        is24HrFormat: true,
        hourLabel: "horas",
        minuteLabel: "minutos",
        value: TimeOfDay(hour: 12, minute: 00),
        onChange: (TimeOfDay time) {
          setHorario(getHorarioFromTime(time));
          addHorario();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 3),
        trailing: InkWell(
          child: const Icon(
            Icons.add,
            color: kPrimaryColor,
            size: 32,
          ),
          onLongPress: () => _speak("Adicione um horário"),
          onTap: showTimePickerDialog,
        ),
        leading: Semantics(
          excludeSemantics: true,
          child: InkWell(
            onTap: () => _speak(horarios.length == 0
                ? "Adicione um horário"
                : horarios.toString()),
            child: Icon(
              Icons.play_circle_fill,
              color: kPrimaryColor,
              size: 42,
            ),
          ),
        ),
        title: horarios.length == 0
            ? Text(
                "Adicione um horário",
                style: TextStyle(color: Colors.grey[700]),
              )
            : NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: horarios
                        .map(
                          (e) => Container(
                            margin: EdgeInsets.only(right: 10),
                            child: RaisedButton(
                              onLongPress: () =>
                                  _speak("$e. Toque para editar/remover."),
                              onPressed: () => showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return ChooseDialog(
                                    () {
                                      removeHorario(e);
                                      showTimePickerDialog();
                                    },
                                    () => removeHorario(e),
                                  );
                                },
                              ),
                              child: Text(
                                e.toString(),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
      ),
    );
  }
}
