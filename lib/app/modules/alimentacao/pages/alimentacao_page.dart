import 'package:dia_vision/app/modules/alimentacao/controllers/alimentacao_controller.dart';
import 'package:dia_vision/app/modules/alimentacao/widgets/alimentacao_widget.dart';
import 'package:dia_vision/app/shared/components/floating_add_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart' as dt;
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

class AlimentacaoPage extends StatefulWidget with ScaffoldUtils {
  AlimentacaoPage({Key? key}) : super(key: key);

  @override
  _AlimentacaoPageState createState() => _AlimentacaoPageState(scaffoldKey);
}

class _AlimentacaoPageState
    extends ModularState<AlimentacaoPage, AlimentacaoController>
    with dt.DateUtil {
  Future _speak(String txt) => Modular.get<FlutterTts>().speak(txt);
  final GlobalKey<ScaffoldState> scaffoldKey;

  _AlimentacaoPageState(this.scaffoldKey);

  @override
  void initState() {
    super.initState();
    controller.getData(widget.onError);
  }

  Future<void> saveRelatorioCsv() async {
    final directory = await getApplicationDocumentsDirectory();
    final pathOfTheFileToWrite = directory.path +
        "/alimentacao_${getDataForFileName(DateTime.now())}.csv";
    final file = await controller.getRelatorioCsvFile(
        widget.onError, pathOfTheFileToWrite);
    if (file != null) await Share.shareFiles([file.path]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingAddButton(
        "$buttonStr $registerStr $alimentationStr",
        "${alimentation.routeName}/$registerStr",
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onLongPress: () => _speak("$buttonStr $shareStr $registryStr"),
              onTap: saveRelatorioCsv,
              child: const Icon(
                Icons.share,
                size: 32,
                semanticLabel: "$buttonStr $shareStr $registryStr",
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            alimentationStr,
            style: TextStyle(
              fontSize: kAppBarTitleSize,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Semantics(
        sortKey: const OrdinalSortKey(1),
        child: Container(
          width: double.infinity,
          height: size.height,
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10),
          child: Observer(
            builder: (_) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.alimentacoes.isEmpty) {
                return const InkWellSpeakText(
                  Text(
                    withoutAlimentationRegistered,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: kPrimaryColor),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.alimentacoes.length,
                itemBuilder: (BuildContext context, int index) {
                  return AlimentacaoWidget(controller.alimentacoes[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
