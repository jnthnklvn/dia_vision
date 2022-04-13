import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class InkWellSpeakText extends StatelessWidget {
  final Text text;

  const InkWellSpeakText(this.text, {Key? key}) : super(key: key);

  Future _speak() => Modular.get<LocalFlutterTts>().speak(text.data ?? '');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => _speak(),
      excludeFromSemantics: true,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: text,
    );
  }
}
