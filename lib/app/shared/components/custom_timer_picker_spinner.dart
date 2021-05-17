import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

import 'ink_well_speak_text.dart';

class CustomTimePickerSpinner extends StatelessWidget {
  const CustomTimePickerSpinner({
    @required this.context,
    @required this.onPressed,
    @required this.onTimeChange,
  });

  final void Function() onPressed;
  final void Function(DateTime) onTimeChange;
  final BuildContext context;

  Future<dynamic> _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        color: Colors.white,
        child: InkWellSpeakText(
          Text(
            "Adicionar horário",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      titlePadding: EdgeInsets.only(top: 10),
      contentPadding: EdgeInsets.only(top: 10),
      actions: [
        RaisedButton(
          child: Text(
            "Cancelar",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          onLongPress: () => _speak("$BUTTON cancelar"),
          onPressed: Navigator.of(context).pop,
          color: kPrimaryColor,
        ),
        RaisedButton(
          child: Text(
            "Adicionar",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          onLongPress: () => _speak("$BUTTON adicionar"),
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
          color: kPrimaryColor,
        ),
      ],
      content: Container(
        color: Colors.white,
        child: TimePickerSpinner(
          normalTextStyle: TextStyle(fontSize: 24, color: kPrimaryColor),
          highlightedTextStyle: TextStyle(fontSize: 24, color: kSecondaryColor),
          itemWidth: 100,
          alignment: Alignment.center,
          time: DateTime(DateTime.now().year, 1, 1, 12, 00),
          isForce2Digits: true,
          onTimeChange: onTimeChange,
        ),
      ),
    );
  }
}
