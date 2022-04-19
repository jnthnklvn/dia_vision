import 'package:dia_vision/app/shared/components/text_field_container.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart' as dt;
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'choose_dialog.dart';

class ContainerFieldHorarios extends StatelessWidget with dt.DateUtil {
  ContainerFieldHorarios({
    Key? key,
    required this.context,
    required this.horarios,
    required this.setHorario,
    required this.addHorario,
    required this.removeHorario,
  }) : super(key: key);

  final void Function(String) setHorario;
  final void Function() addHorario;
  final void Function(String) removeHorario;
  final List<String> horarios;
  final BuildContext context;

  Future<dynamic> _speak(String txt) =>
      Modular.get<LocalFlutterTts>().speak(txt);

  Future showTimePickerDialog() {
    return Navigator.of(context).push(
      showPicker(
        context: context,
        cancelText: cancellStr,
        okText: addStr,
        is24HrFormat: true,
        hourLabel: "horas",
        minuteLabel: "minutos",
        value: const TimeOfDay(hour: 12, minute: 00),
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
        contentPadding: const EdgeInsets.symmetric(vertical: 3),
        trailing: InkWell(
          child: const Icon(
            Icons.add,
            color: kPrimaryColor,
            size: 32,
          ),
          onLongPress: () => _speak(addTime),
          onTap: showTimePickerDialog,
        ),
        leading: Semantics(
          excludeSemantics: true,
          child: InkWell(
            onTap: () =>
                _speak(horarios.isEmpty ? addTime : horarios.toString()),
            child: const Icon(
              Icons.play_circle_fill,
              color: kPrimaryColor,
              size: 42,
            ),
          ),
        ),
        title: horarios.isEmpty
            ? Text(
                addTime,
                style: Theme.of(context).textTheme.bodyText1,
              )
            : NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: horarios
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
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
