import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/components/semantic_icon_play.dart';
import 'package:dia_vision/app/shared/preferences/config_preferences.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  Future<void> init() async {
    final isAppFirstRun =
        await Modular.get<ConfigPreferences>().getIsAppFirstRun() ?? true;
    if (!isAppFirstRun) {
      Modular.to.pushReplacementNamed(RouteEnum.auth.name);
    }
  }

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    init();
    return IntroductionScreen(
      pages: [
        PageViewModel(
          image: Center(
            child: Image.asset(
              "assets/images/pedestrian_crossing.png",
              excludeFromSemantics: true,
              height: 175.0,
            ),
          ),
          titleWidget: InkWellSpeakText(Text(
            "Acessibilidade",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
              color: kPrimaryColor,
            ),
          )),
          bodyWidget: Center(
            child: InkWellSpeakText(
              Text(
                INTRO_PAGE_1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          footer: SemanticIconPlay(text: INTRO_PAGE_1, size: 54),
        ),
      ],
      onDone: () {},
      next: const Icon(
        Icons.play_arrow_rounded,
        semanticLabel: "Botão: próxima página.",
        size: 36,
        color: kSecondaryColor,
      ),
      done: FlatButton(
        minWidth: 100,
        onLongPress: () => _speak("Botão: Pronto"),
        child: Text(
          'Pronto',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kSecondaryColor,
          ),
        ),
        onPressed: () {
          Modular.get<ConfigPreferences>().setIsAppFirstRun(false);
          Modular.to.pushReplacementNamed(RouteEnum.auth.name);
        },
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: kPrimaryColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
