import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/shared/preferences/config_preferences.dart';
import 'package:dia_vision/app/shared/components/semantic_icon_play.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
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

  Future _speak(String txt) => Modular.get<LocalFlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatingOptionsButton(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0),
                    child: Image.asset(
                      "assets/images/pedestrian_crossing.png",
                      excludeFromSemantics: true,
                      height: 175.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: InkWellSpeakText(
                      Text(
                        "Componentes Acessíveis",
                        style: Theme.of(context).textTheme.bodyText1?.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Center(
                      child: InkWellSpeakText(
                        Text(
                          introPage1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: SemanticIconPlay(text: introPage1, size: 54),
                  ),
                ],
              ),
            ),
            bodyWidget: Container(),
          ),
          PageViewModel(
            titleWidget: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0),
                    child: Image.asset(
                      "assets/images/undraw_web_browsing.png",
                      excludeFromSemantics: true,
                      height: 175.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: InkWellSpeakText(
                      Text(
                        "Botão de Acessibilidade",
                        style: Theme.of(context).textTheme.bodyText1?.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Center(
                      child: InkWellSpeakText(
                        Text(
                          introPage2,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: SemanticIconPlay(text: introPage2, size: 54),
                  ),
                ],
              ),
            ),
            bodyWidget: Container(),
          ),
        ],
        onDone: onDone,
        nextSemantic: 'Botão: avançar página.',
        next: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 36,
          color: kPrimaryColor,
        ),
        showBackButton: true,
        backSemantic: 'Botão: voltar página.',
        back: const Icon(
          Icons.arrow_back_ios_rounded,
          size: 36,
          color: kPrimaryColor,
        ),
        doneSemantic: 'Botão: Pronto',
        done: Text(
          'Pronto',
          style: Theme.of(context).textTheme.headline6?.merge(
                const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
        ),
        onLongPress: _speak,
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: kPrimaryColor,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black26
              : Colors.white54,
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
