import 'package:dia_vision/app/app_controller.dart';

import 'package:flutter_tts/flutter_tts.dart';

class LocalFlutterTts extends FlutterTts {
  final AppController controller;
  LocalFlutterTts(this.controller) : super();

  @override
  Future<void> speak(String text) async {
    if (controller.isVoiceFeedbackActive) {
      return await super.speak(text);
    }
  }
}
