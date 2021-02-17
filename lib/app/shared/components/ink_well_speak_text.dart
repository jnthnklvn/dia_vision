import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class InkWellSpeakText extends StatelessWidget {
  final Text text;

  const InkWellSpeakText(this.text);

  Future _speak() => Modular.get<FlutterTts>().speak(text.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => _speak(),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: text,
    );
  }
}