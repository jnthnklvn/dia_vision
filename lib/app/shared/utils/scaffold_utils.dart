import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/components/snack_bars.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class ScaffoldUtils {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future speak(String txt) => Modular.get<LocalFlutterTts>().speak(txt);

  void onError(String message) {
    ScaffoldMessenger.of(scaffoldKey.currentState!.context)
        .showSnackBar(SnackBars.error(message));
    speak(message);
  }

  void onSuccess(String message) {
    ScaffoldMessenger.of(scaffoldKey.currentState!.context)
        .showSnackBar(SnackBars.confirmation(message));
    speak(message);
  }
}
