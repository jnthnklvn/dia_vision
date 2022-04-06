import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class AlertMsgDialog extends StatelessWidget {
  final Function()? onConfirm;
  final String btnName;
  final String content;
  final String title;

  const AlertMsgDialog(this.onConfirm, this.btnName, this.content, this.title,
      {Key? key})
      : super(key: key);

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: InkWellSpeakText(Text(title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600))),
      contentPadding:
          const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
      content: InkWellSpeakText(
        Text(
          content,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.justify,
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(color: Colors.white),
            ),
            minimumSize: const Size(100, 40),
          ),
          onLongPress: () => _speak("Botão: $btnName"),
          child: Text(btnName,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          onPressed: onConfirm != null
              ? () {
                  Navigator.of(context).pop();
                  onConfirm!();
                }
              : Navigator.of(context).pop,
        ),
      ],
    );
  }
}
