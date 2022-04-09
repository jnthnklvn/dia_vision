import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/preferences/config_preferences.dart';
import 'package:dia_vision/app/shared/components/semantic_icon_play.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  Future<void> init() async {
    final isAppFirstRun =
        await Modular.get<ConfigPreferences>().getIsAppFirstRun() ?? true;
    if (!isAppFirstRun) {
      Modular.to.pushReplacementNamed('${RouteEnum.auth.name}/');
    }
  }

  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingOptionsButton(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            image: Center(
              child: Image.asset(
                "assets/images/pedestrian_crossing.png",
                excludeFromSemantics: true,
                height: 175.0,
              ),
            ),
            titleWidget: InkWellSpeakText(
              Text(
                "Acessibilidade",
                style: Theme.of(context).textTheme.bodyText1?.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
              ),
            ),
            bodyWidget: Center(
              child: InkWellSpeakText(
                Text(
                  introPage1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            footer: SemanticIconPlay(text: introPage1, size: 54),
          ),
        ],
        onDone: onDone,
        next: const Icon(
          Icons.play_arrow_rounded,
          semanticLabel: "Botão: próxima página.",
          size: 36,
          color: kSecondaryColor,
        ),
        done: InkWell(
          onLongPress: () => _speak("Botão: Pronto"),
          onTap: onDone,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Pronto',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
          ),
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
      ),
    );
  }

  void onDone() {
    Modular.get<ConfigPreferences>().setIsAppFirstRun(false);
    Modular.to.pushReplacementNamed('${RouteEnum.auth.name}/');
  }
}
