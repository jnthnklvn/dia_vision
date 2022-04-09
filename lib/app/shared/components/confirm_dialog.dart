import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
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

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

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
              side: const BorderSide(color: Colors.white),
            ),
            minimumSize: const Size(100, 40),
          ),
          onLongPress: () => _speak("Botão: não"),
          child:
              const Text('Não', style: TextStyle(fontWeight: FontWeight.w600)),
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
          child:
              const Text('Sim', style: TextStyle(fontWeight: FontWeight.w600)),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
      ],
    );
  }
}
