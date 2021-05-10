import 'package:dia_vision/app/shared/components/snack_bars.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class ScaffoldUtils {
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  void onError(String message) {
    scaffoldKey.currentState?.showSnackBar(SnackBars.error(message));
    _speak(message);
  }

  void onSuccess(String message) {
    scaffoldKey.currentState?.showSnackBar(SnackBars.confirmation(message));
    _speak(message);
  }
}
