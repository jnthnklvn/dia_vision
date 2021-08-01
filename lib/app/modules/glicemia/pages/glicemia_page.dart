import 'package:dia_vision/app/modules/glicemia/controllers/glicemia_controller.dart';
import 'package:dia_vision/app/modules/glicemia/widgets/glicemia_widget.dart';
import 'package:dia_vision/app/shared/components/floating_add_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/confirm_dialog.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/route_enum.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:flutter/semantics.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GlicemiaPage extends StatefulWidget with ScaffoldUtils {
  @override
  _GlicemiaPageState createState() => _GlicemiaPageState(scaffoldKey);
}

class _GlicemiaPageState extends ModularState<GlicemiaPage, GlicemiaController>
    with DateUtils {
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);
  final GlobalKey<ScaffoldState> scaffoldKey;

  _GlicemiaPageState(this.scaffoldKey);

  @override
  void initState() {
    super.initState();
    controller.getData(widget.onError);
  }

  Future<void> saveRelatorioCsv() async {
    final directory = await getApplicationDocumentsDirectory();
    final pathOfTheFileToWrite =
        directory.path + "/glicemia_${getDataForFileName(DateTime.now())}.csv";
    final file = await controller.getRelatorioCsvFile(
        widget.onError, pathOfTheFileToWrite);
    if (file != null) await Share.shareFiles([file.path]);
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ConfirmDialog(
          () => Modular.to
              .pushNamed(RouteEnum.profile.name + RouteEnum.preferences.name),
          'Limites de glicemia',
          'Você ainda não definiu os valores minimo e máximo para glicemia. O valor padrão de 120 mg/dL para máxima e 70 mg/dL para minima está sendo utilizado. Gostaria de defini-los agora?',
          onCancell: () {
            Modular.to.pushNamed("${glicemy.routeName}/$REGISTER");
            controller.setIsValorPadraoGlicemia(false);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingAddButton(
        "$BUTTON $ADD $REGISTRY",
        "${glicemy.routeName}/$REGISTER",
        onPressed: () => controller.isValorPadraoGlicemia
            ? _showMyDialog()
            : Modular.to.pushNamed("${glicemy.routeName}/$REGISTER"),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onLongPress: () => _speak("$BUTTON $SHARE $REGISTRY"),
              onTap: saveRelatorioCsv,
              child: Icon(
                Icons.share,
                size: 32,
                semanticLabel: "$BUTTON $SHARE $REGISTRY",
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            GLICEMY,
            style: TextStyle(
              fontSize: kAppBarTitleSize,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Semantics(
        sortKey: OrdinalSortKey(1),
        child: Container(
          width: double.infinity,
          height: size.height,
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 10),
          child: Observer(
            builder: (_) {
              if (controller.isLoading)
                return Center(child: CircularProgressIndicator());
              if (controller.glicemias.isEmpty)
                return InkWellSpeakText(
                  Text(
                    WITHOUT_GLICEMY_REGISTERED,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: kPrimaryColor),
                  ),
                );
              return ListView.builder(
                itemCount: controller.glicemias.length,
                itemBuilder: (BuildContext context, int index) {
                  return GlicemiaWidget(controller.glicemias[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
