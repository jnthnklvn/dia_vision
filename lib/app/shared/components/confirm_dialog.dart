import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onConfirm;
  final Function() onCancell;

  const ConfirmDialog(
    this.onConfirm,
    this.title,
    this.content, {
    this.onCancell,
  });

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: InkWellSpeakText(Text(title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))),
      contentPadding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
      content: InkWellSpeakText(
        Text(
          content,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.justify,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          minWidth: 100,
          color: Colors.red,
          onLongPress: () => _speak("Botão: não"),
          child: Text('Não',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          onPressed: onCancell != null
              ? () {
                  Navigator.of(context).pop();
                  onCancell();
                }
              : Navigator.of(context).pop,
        ),
        FlatButton(
          minWidth: 100,
          color: Colors.blue,
          onLongPress: () => _speak("Botão: sim"),
          child: Text('Sim',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
      ],
    );
  }
}
