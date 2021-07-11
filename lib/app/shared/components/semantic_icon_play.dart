import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class SemanticIconPlay extends StatelessWidget with DateUtils {
  const SemanticIconPlay({
    @required this.text,
    this.size = 42,
  });

  final String text;
  final double size;

  Future<dynamic> _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      excludeSemantics: true,
      child: InkWell(
        onTap: () => _speak(text),
        onLongPress: () => _speak("Botão: ouvir descrição."),
        child: Icon(
          Icons.play_circle_fill,
          color: kPrimaryColor,
          size: size,
        ),
      ),
    );
  }
}
