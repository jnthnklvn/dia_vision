import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/utils/size_config.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:dia_vision/app/shared/utils/styles.dart';
import 'package:dia_vision/app/app_controller.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
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
          title: InkWellSpeakText(
            Text(
              'Dados de Paciente',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          contentPadding:
              EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
          content: InkWellSpeakText(
            Text(
              "Para acessar esse módulo é necessário preencher algumas informações como nome, peso e altura no perfil. " +
                  "Clique no botão 'Ir' abaixo para ir para a tela de preenchimento.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              minWidth: 100,
              color: kPrimaryColor,
              onLongPress: () => _speak("Botão: ir"),
              child: Text('Ir',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              onPressed: () {
                Navigator.of(context).pop();
                Modular.to
                    .pushNamed(RouteEnum.profile.name + RouteEnum.my_data.name);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/logo_name.png",
                  height: 60,
                  excludeFromSemantics: true,
                ),
                Semantics(
                  label: "$BUTTON $SETTINGS",
                  child: InkWell(
                    onTap: () => Modular.to.pushNamed(RouteEnum.profile.name),
                    onLongPress: () => _speak("$BUTTON $SETTINGS"),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/icons/Settings.svg",
                        color: kSecondaryColor,
                        height: 35,
                        excludeFromSemantics: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            InkWellSpeakText(
              Text(
                "Seja bem-vindo",
                style: headingStyle,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: modules.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      if (modules[index].needPatient &&
                          !(await _controller.hasPatient())) {
                        _showMyDialog();
                      } else {
                        Modular.to.pushNamed(modules[index].routeName);
                      }
                    },
                    onLongPress: () => _speak("$MODULE " + modules[index].name),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFF00778C),
                      ),
                      width: SizeConfig.screenWidth / 2.5,
                      height: SizeConfig.screenWidth / 2.5,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(30, 30, 5, 5),
                            child: modules[index].svg
                                ? SvgPicture.asset(
                                    modules[index].imageSrc,
                                    fit: BoxFit.fill,
                                    alignment: Alignment.centerRight,
                                    excludeFromSemantics: true,
                                  )
                                : Image(
                                    image: AssetImage(modules[index].imageSrc),
                                    fit: BoxFit.fill,
                                    alignment: Alignment.centerRight,
                                    excludeFromSemantics: true,
                                  ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
                            child: Text(
                              modules[index].name,
                              semanticsLabel: "$MODULE ${modules[index].name}",
                              style: kTitleTextStyle.apply(
                                backgroundColor: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
