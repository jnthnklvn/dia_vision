import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class ChooseDialog extends StatelessWidget {
  final Function() onConfirm;
  final Function()? onCancell;

  const ChooseDialog(
    this.onConfirm,
    this.onCancell, {
    Key? key,
  }) : super(key: key);

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      actionsPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      content: Container(
        color: Colors.yellowAccent,
        height: 100,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                onLongPress: () => _speak("Botão: editar"),
                child: const Text('Editar',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                onLongPress: () => _speak("Botão: remover"),
                child: const Text('Remover',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                onPressed: onCancell != null
                    ? () {
                        Navigator.of(context).pop();
                        onCancell!();
                      }
                    : Navigator.of(context).pop,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
