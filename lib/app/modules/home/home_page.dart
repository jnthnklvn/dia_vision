import 'package:dia_vision/app/shared/components/floating_options_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/size_config.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppController _controller = Modular.get<AppController>();
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);

  @override
  void initState() {
    _controller.startListenNotifications();
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const InkWellSpeakText(
            Text(
              'Dados de Paciente',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          contentPadding:
              const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
          content: const InkWellSpeakText(
            Text(
              "Para acessar esse módulo é necessário preencher algumas informações como nome, peso e altura no perfil. "
              "Clique no botão 'Ir' abaixo para ir para a tela de preenchimento.",
              textAlign: TextAlign.justify,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: kPrimaryColor,
                minimumSize: const Size(100, 40),
              ),
              onLongPress: () => _speak("Botão: ir"),
              child: const Text('Ir',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              onPressed: () {
                Navigator.of(context).pop();
                Modular.to
                    .pushNamed(RouteEnum.profile.name + RouteEnum.myData.name);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    SizeConfig.init(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatingOptionsButton(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color:
                  isDark ? Colors.white24 : Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Theme.of(context).brightness == Brightness.dark
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: buildLogo(),
                          )
                        : buildLogo(),
                    Semantics(
                      label: "$buttonStr $settingsStr",
                      child: InkWell(
                        onTap: () =>
                            Modular.to.pushNamed('${RouteEnum.profile.name}/'),
                        onLongPress: () => _speak("$buttonStr $settingsStr"),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            "assets/icons/Settings.svg",
                            color: isDark ? kPrimaryColor : kSecondaryColor,
                            height: 35,
                            excludeFromSemantics: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AlignedGridView.count(
                  padding: const EdgeInsets.all(0),
                  crossAxisCount: 2,
                  itemCount: modules.length,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        if (modules[index].needPatient &&
                            !(await _controller.hasPatient())) {
                          _showMyDialog();
                        } else {
                          Modular.to.pushNamed('${modules[index].routeName}/');
                        }
                      },
                      onLongPress: () =>
                          _speak("$moduleStr " + modules[index].name),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xFF00778C),
                        ),
                        width: SizeConfig.screenWidth != null
                            ? SizeConfig.screenWidth! / 2.5
                            : null,
                        height: SizeConfig.screenWidth != null
                            ? SizeConfig.screenWidth! / 2.5
                            : null,
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(30, 30, 5, 5),
                              child: modules[index].svg
                                  ? SvgPicture.asset(
                                      modules[index].imageSrc,
                                      fit: BoxFit.fill,
                                      alignment: Alignment.centerRight,
                                      excludeFromSemantics: true,
                                    )
                                  : Image(
                                      image:
                                          AssetImage(modules[index].imageSrc),
                                      fit: BoxFit.fill,
                                      alignment: Alignment.centerRight,
                                      excludeFromSemantics: true,
                                    ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 20, 20),
                              child: Text(
                                modules[index].name,
                                semanticsLabel:
                                    "$moduleStr ${modules[index].name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.apply(
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                      backgroundColor: isDark
                                          ? Colors.black.withOpacity(0.5)
                                          : Colors.white.withOpacity(0.5),
                                    )
                                    .merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Image buildLogo() {
    return Image.asset(
      "assets/images/logo_name.png",
      height: 60,
      excludeFromSemantics: true,
    );
  }
}
