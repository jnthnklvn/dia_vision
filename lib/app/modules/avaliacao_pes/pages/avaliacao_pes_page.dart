import 'package:dia_vision/app/modules/avaliacao_pes/controllers/avaliacao_pes_controller.dart';
import 'package:dia_vision/app/modules/avaliacao_pes/widgets/avaliacao_pes_widget.dart';
import 'package:dia_vision/app/shared/components/floating_add_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/date_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';
import 'package:flutter/semantics.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

class AvaliacaoPesPage extends StatefulWidget with ScaffoldUtils {
  AvaliacaoPesPage({Key? key}) : super(key: key);

  @override
  _AvaliacaoPesPageState createState() => _AvaliacaoPesPageState();
}

class _AvaliacaoPesPageState
    extends ModularState<AvaliacaoPesPage, AvaliacaoPesController>
    with DateUtil {
  @override
  void initState() {
    super.initState();
    controller.getData(widget.onError);
  }

  Future<void> saveRelatorioCsv() async {
    final directory = await getApplicationDocumentsDirectory();
    final pathOfTheFileToWrite = directory.path +
        "/avaliacoes_pes_${getDataForFileName(DateTime.now())}.csv";
    final file = await controller.getRelatorioCsvFile(
        widget.onError, pathOfTheFileToWrite);
    if (file != null) await Share.shareFiles([file.path]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: widget.scaffoldKey,
      floatingActionButton: FloatingAddButton(
        "$buttonStr $addStr $registryStr",
        "${feet.routeName}/$registerStr",
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onLongPress: () =>
                  widget.speak("$buttonStr $shareStr $registryStr"),
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
            feetCheck,
            style: TextStyle(
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
          color: Theme.of(context).backgroundColor,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10),
          child: Observer(
            builder: (_) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.avaliacoes.isEmpty) {
                return InkWellSpeakText(
                  Text(
                    withoutFeetCheckRegistered,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.apply(color: kPrimaryColor),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.avaliacoes.length,
                itemBuilder: (BuildContext context, int index) {
                  return AvaliacaoPesWidget(controller.avaliacoes[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
