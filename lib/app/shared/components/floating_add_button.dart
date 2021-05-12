import 'package:dia_vision/app/shared/utils/constants.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  final String semanticsLabel;
  final String route;

  const FloatingAddButton(this.semanticsLabel, this.route);

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      sortKey: OrdinalSortKey(0),
      child: InkWell(
        onLongPress: () => _speak(semanticsLabel),
        child: FloatingActionButton(
          onPressed: () => Modular.to.pushNamed(route),
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
      label: semanticsLabel,
    );
  }
}
