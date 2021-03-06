import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onConfirm;
  final Function()? onCancell;

  const ConfirmDialog(
    this.onConfirm,
    this.title,
    this.content, {
    Key? key,
    this.onCancell,
  }) : super(key: key);

  Future _speak(String txt) => Modular.get<LocalFlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: InkWellSpeakText(
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
      contentPadding:
          const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
      content: InkWellSpeakText(
        Text(
          content,
          textAlign: TextAlign.justify,
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Theme.of(context).backgroundColor),
            ),
            minimumSize: const Size(100, 40),
          ),
          onLongPress: () => _speak("Botão: não"),
          child: Text(
            'Não',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          onPressed: onCancell != null
              ? () {
                  Navigator.of(context).pop();
                  onCancell!();
                }
              : Navigator.of(context).pop,
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(color: Colors.white),
            ),
            minimumSize: const Size(100, 40),
          ),
          onLongPress: () => _speak("Botão: sim"),
          child: Text(
            'Sim',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
      ],
    );
  }
}
