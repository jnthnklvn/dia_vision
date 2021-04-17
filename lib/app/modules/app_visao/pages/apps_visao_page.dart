import 'package:dia_vision/app/modules/app_visao/controllers/app_visao_controller.dart';
import 'package:dia_vision/app/modules/app_visao/widgets/app_visao_widget.dart';
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

class AppsVisaoPage extends StatefulWidget with ScaffoldUtils {
  @override
  _AppsVisaoPageState createState() => _AppsVisaoPageState(scaffoldKey);
}

class _AppsVisaoPageState
    extends ModularState<AppsVisaoPage, AppVisaoController> {
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);
  final GlobalKey<ScaffoldState> scaffoldKey;

  _AppsVisaoPageState(this.scaffoldKey);

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
        onLongPress: () => _speak("$BUTTON $SUGGEST $VISION_APP_TITLE"),
        child: FloatingActionButton(
          onPressed: () =>
              Modular.to.pushNamed("${vision.routeName}/$REGISTER"),
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add, size: 32),
        ),
      ),
      appBar: AppBar(
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            VISION_APPS,
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
            if (controller.apps.isEmpty)
              return InkWellSpeakText(
                Text(
                  WITHOUT_VISION_APP_REGISTERED,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              );
            return ListView.builder(
              itemCount: controller.apps.length,
              itemBuilder: (BuildContext context, int index) {
                return AppVisaoWidget(controller.apps[index], widget.onError);
              },
            );
          },
        ),
      ),
    );
  }
}
