import 'package:dia_vision/app/modules/medications/widgets/medication_widget.dart';
import 'package:dia_vision/app/modules/medications/medications_controller.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class MedicationsPage extends StatefulWidget with ScaffoldUtils {
  @override
  _MedicationsPageState createState() => _MedicationsPageState(scaffoldKey);
}

class _MedicationsPageState
    extends ModularState<MedicationsPage, MedicationsController>
    with DateUtils {
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);
  final GlobalKey<ScaffoldState> scaffoldKey;

  _MedicationsPageState(this.scaffoldKey);

  @override
  void initState() {
    super.initState();
    controller.getData(widget.onError);
  }

  Future<void> saveRelatorioCsv() async {
    final directory = await getApplicationDocumentsDirectory();
    final pathOfTheFileToWrite = directory.path +
        "/medicacoes_${getDataForFileName(DateTime.now())}.csv";
    final file = await controller.getRelatorioCsvFile(
        widget.onError, pathOfTheFileToWrite);
    if (file != null) await Share.shareFiles([file.path]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: InkWell(
        onLongPress: () => _speak("$BUTTON $ADD $REGISTRY"),
        child: FloatingActionButton(
          onPressed: () =>
              Modular.to.pushNamed("${medications.routeName}/$REGISTER"),
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add, size: 32),
        ),
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
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
        leading: BackArrowButton(iconPadding: 5),
        title: InkWellSpeakText(
          Text(
            MEDICATIONS,
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
        padding: const EdgeInsets.only(top: 10),
        child: Observer(
          builder: (_) {
            if (controller.isLoading)
              return Center(child: CircularProgressIndicator());
            if (controller.medicacoes.isEmpty)
              return InkWellSpeakText(
                Text(
                  WITHOUT_MEDICACOES_REGISTERED,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              );
            return ListView.builder(
              itemCount: controller.medicacoes.length,
              itemBuilder: (BuildContext context, int index) {
                return MedicationWidget(controller.medicacoes[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
