import 'package:dia_vision/app/modules/centro_saude/controllers/centro_saude_controller.dart';
import 'package:dia_vision/app/modules/centro_saude/widgets/centro_saude_widget.dart';
import 'package:dia_vision/app/shared/components/floating_add_button.dart';
import 'package:dia_vision/app/shared/components/ink_well_speak_text.dart';
import 'package:dia_vision/app/modules/home/domain/entities/module.dart';
import 'package:dia_vision/app/shared/components/back_arrow_button.dart';
import 'package:dia_vision/app/shared/components/local_flutter_tts.dart';
import 'package:dia_vision/app/shared/utils/scaffold_utils.dart';
import 'package:dia_vision/app/shared/utils/color_utils.dart';
import 'package:dia_vision/app/shared/utils/constants.dart';
import 'package:dia_vision/app/shared/utils/strings.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

class CentrosSaudePage extends StatefulWidget with ScaffoldUtils {
  CentrosSaudePage({Key? key}) : super(key: key);

  @override
  _CentrosSaudePageState createState() => _CentrosSaudePageState();
}

class _CentrosSaudePageState
    extends ModularState<CentrosSaudePage, CentroSaudeController> {
  @override
  void initState() {
    super.initState();
    controller.getData(widget.onError);
  }

  Future _speak(String txt) => Modular.get<LocalFlutterTts>().speak(txt);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: widget.scaffoldKey,
      floatingActionButton: FloatingAddButton(
        "$buttonStr $suggestStr $medicalCenterTitle",
        "${medicalCentersModule.routeName}/$registerStr",
      ),
      appBar: AppBar(
        leading: const BackArrowButton(iconPadding: 5),
        title: const InkWellSpeakText(
          Text(
            medicalCenters,
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
          child: Observer(
            builder: (_) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.centros.isEmpty) {
                return InkWellSpeakText(
                  Text(
                    withoutMedicalCenterRegistered,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.apply(color: kPrimaryColor),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.centros.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return buildListTitle(context);
                  }
                  return CentroSaudeWidget(controller.centros[index - 1]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildListTitle(BuildContext context) {
    return InkWell(
      onLongPress: () => _speak(
        "Opção " +
            (controller.tipo ?? "Todas os tipos") +
            " selecionada, toque para $changeStr",
      ),
      onTap: () => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: buildDropdownButton(),
          );
        },
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            controller.tipo ?? "Todas os tipos",
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.filter_alt_outlined,
              size: 32,
              semanticLabel: "$buttonStr $changeStr $typeStr",
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownButton() {
    return Observer(builder: (_) {
      return SingleChildScrollView(
          child: Column(
        children: [
          buildDropdownMenuItem(allTypes, getColorToTipo(allTypes)),
          ...controller.tipos.map<DropdownMenuItem<String>>((String? str) {
            return buildDropdownMenuItem(
              str ?? '',
              getColorToTipo(str),
            );
          }).toList()
        ],
      ));
    });
  }

  Color getColorToTipo(String? str) {
    if (str?.isNotEmpty != true) return ColorUtils.colors[0];
    final idx = controller.tipos.toList().indexOf(str);
    return ColorUtils.colors[idx % ColorUtils.colors.length];
  }

  DropdownMenuItem<String> buildDropdownMenuItem(String str, Color color) {
    return DropdownMenuItem<String>(
      value: str,
      child: InkWell(
        onTap: () {
          controller.filterData(str);
          Modular.to.pop();
        },
        onLongPress: () => _speak(str),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [color, color.withOpacity(0.1)],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            title: Text(
              str,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
