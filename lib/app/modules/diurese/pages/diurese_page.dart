import 'package:dia_vision/app/modules/diurese/controllers/diurese_controller.dart';
import 'package:dia_vision/app/modules/diurese/widgets/diurese_widget.dart';
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

class DiuresePage extends StatefulWidget with ScaffoldUtils {
  @override
  _DiuresePageState createState() => _DiuresePageState(scaffoldKey);
}

class _DiuresePageState extends ModularState<DiuresePage, DiureseController>
    with DateUtils {
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);
  final GlobalKey<ScaffoldState> scaffoldKey;

  _DiuresePageState(this.scaffoldKey);

  @override
  void initState() {
    super.initState();
    controller.getData(widget.onError);
  }

  Future<void> saveRelatorioCsv() async {
    final directory = await getApplicationDocumentsDirectory();
    final pathOfTheFileToWrite =
        directory.path + "/diurese_${getDataForFileName(DateTime.now())}.csv";
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
              Modular.to.pushNamed("${kidney.routeName}/$REGISTER"),
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
            KIDNEY_DIURESIS,
            style: TextStyle(
              fontSize: 24,
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
            if (controller.diureses.isEmpty)
              return InkWellSpeakText(
                Text(
                  WITHOUT_DIURESIS_REGISTERED,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              );
            return ListView.builder(
              itemCount: controller.diureses.length,
              itemBuilder: (BuildContext context, int index) {
                return DiureseWidget(controller.diureses[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
