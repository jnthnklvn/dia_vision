import 'package:dia_vision/app/modules/centro_saude/controllers/centro_saude_controller.dart';
import 'package:dia_vision/app/modules/centro_saude/widgets/centro_saude_widget.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class CentrosSaudePage extends StatefulWidget with ScaffoldUtils {
  @override
  _CentrosSaudePageState createState() => _CentrosSaudePageState(scaffoldKey);
}

class _CentrosSaudePageState
    extends ModularState<CentrosSaudePage, CentroSaudeController> {
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);
  final GlobalKey<ScaffoldState> scaffoldKey;

  _CentrosSaudePageState(this.scaffoldKey);

  @override
  void initState() {
    super.initState();
    controller.getData(widget.onError);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: InkWell(
        onLongPress: () => _speak("$BUTTON $SUGGEST $MEDICAL_CENTER_TITLE"),
        child: FloatingActionButton(
          onPressed: () =>
              Modular.to.pushNamed("${medicalCenters.routeName}/$REGISTER"),
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add, size: 32),
        ),
      ),
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            MEDICAL_CENTERS,
            style: TextStyle(
              fontSize: kAppBarTitleSize,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10),
        child: Observer(
          builder: (_) {
            if (controller.isLoading)
              return Center(child: CircularProgressIndicator());
            if (controller.centros.isEmpty)
              return InkWellSpeakText(
                Text(
                  WITHOUT_MEDICAL_CENTER_REGISTERED,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              );
            return ListView.builder(
              itemCount: controller.centros.length,
              itemBuilder: (BuildContext context, int index) {
                return CentroSaudeWidget(controller.centros[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
