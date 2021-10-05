import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class AlertMsgDialog extends StatelessWidget {
  final Function() onConfirm;
  final String btnName;
  final String content;
  final String title;

  const AlertMsgDialog(this.onConfirm, this.btnName, this.content, this.title);

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
          color: Colors.blue,
          onLongPress: () => _speak("Botão: $btnName"),
          child: Text(btnName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          onPressed: onConfirm != null
              ? () {
                  Navigator.of(context).pop();
                  onConfirm();
                }
              : Navigator.of(context).pop,
        ),
      ],
    );
  }
}
